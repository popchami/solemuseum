#!/usr/bin/env python3
"""Validate Kick×Kick data master and proposal JSON files.

This script intentionally uses only Python standard library so it can run in
GitHub Actions without extra dependencies.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"
PROPOSALS = DATA / "proposals"

REQUIRED_FILES = {
    "brands": DATA / "brands.json",
    "models": DATA / "models.json",
    "aliases": DATA / "aliases.json",
    "keywords": DATA / "search_keywords.json",
}

BROAD_TERMS = {
    "air",
    "max",
    "gel",
    "cloud",
    "nike",
    "adidas",
    "jordan",
    "new balance",
    "asics",
}

ALLOWED_TIERS = {"S", "A", "B", "C", "D", "E", "Planned"}
ALLOWED_SOURCES = {"master", "user_input"}
ALLOWED_PROPOSAL_STATUS = {"proposal", "approved", "rejected", "merged"}
ALLOWED_RISK = {"low", "medium", "high"}

ID_PATTERN = re.compile(r"^[a-z0-9_]+$")
DATE_PATTERN = re.compile(r"^\d{4}-\d{2}-\d{2}$")


def load_json(path: Path) -> dict[str, Any]:
    if not path.exists():
        raise ValueError(f"Missing file: {path}")
    try:
        with path.open("r", encoding="utf-8") as f:
            data = json.load(f)
    except json.JSONDecodeError as e:
        raise ValueError(f"Invalid JSON in {path}: {e}") from e
    if not isinstance(data, dict):
        raise ValueError(f"Root must be object: {path}")
    return data


def require_header(name: str, data: dict[str, Any]) -> list[str]:
    errors: list[str] = []
    if not isinstance(data.get("version"), str) or not data["version"]:
        errors.append(f"{name}: version is required")
    if not isinstance(data.get("updatedAt"), str) or not DATE_PATTERN.match(data["updatedAt"]):
        errors.append(f"{name}: updatedAt must be YYYY-MM-DD")
    if not isinstance(data.get("items"), list):
        errors.append(f"{name}: items must be an array")
    return errors


def validate_alias_value(context: str, value: Any) -> list[str]:
    errors: list[str] = []
    if not isinstance(value, str) or not value:
        errors.append(f"{context}: alias is required")
        return errors
    normalized = value.strip().lower()
    if normalized in BROAD_TERMS:
        errors.append(f"{context}: broad alias is forbidden: {value}")
    return errors


def validate_keyword_value(context: str, value: Any) -> list[str]:
    errors: list[str] = []
    if not isinstance(value, str) or not value:
        errors.append(f"{context}: keyword is required")
        return errors
    normalized = value.strip().lower()
    if normalized in BROAD_TERMS:
        errors.append(f"{context}: broad keyword is forbidden: {value}")
    if len(normalized) == 1 and normalized.isalnum():
        errors.append(f"{context}: 1-character keyword is forbidden: {value}")
    return errors


def validate_master_data() -> tuple[list[str], set[str], set[str]]:
    errors: list[str] = []
    loaded = {name: load_json(path) for name, path in REQUIRED_FILES.items()}

    for name, data in loaded.items():
        errors.extend(require_header(name, data))

    brand_ids: set[str] = set()
    model_ids: set[str] = set()

    for item in loaded["brands"].get("items", []):
        if not isinstance(item, dict):
            errors.append("brands: item must be object")
            continue
        brand_id = item.get("brandId")
        if not isinstance(brand_id, str) or not ID_PATTERN.match(brand_id):
            errors.append(f"brands: invalid brandId: {brand_id}")
            continue
        if brand_id in brand_ids:
            errors.append(f"brands: duplicate brandId: {brand_id}")
        brand_ids.add(brand_id)
        if not isinstance(item.get("brandName"), str) or not item["brandName"]:
            errors.append(f"brands: brandName required for {brand_id}")
        if item.get("tier") not in ALLOWED_TIERS:
            errors.append(f"brands: invalid tier for {brand_id}: {item.get('tier')}")
        if not isinstance(item.get("isEnabled"), bool):
            errors.append(f"brands: isEnabled must be boolean for {brand_id}")

    model_key_pairs: set[tuple[str, str]] = set()
    for item in loaded["models"].get("items", []):
        if not isinstance(item, dict):
            errors.append("models: item must be object")
            continue
        model_id = item.get("id")
        brand_id = item.get("brandId")
        model_name = item.get("modelName")
        if not isinstance(model_id, str) or not ID_PATTERN.match(model_id):
            errors.append(f"models: invalid id: {model_id}")
            continue
        if model_id in model_ids:
            errors.append(f"models: duplicate id: {model_id}")
        model_ids.add(model_id)
        if brand_id not in brand_ids:
            errors.append(f"models: brandId not found for {model_id}: {brand_id}")
        if not isinstance(model_name, str) or not model_name:
            errors.append(f"models: modelName required for {model_id}")
        else:
            pair = (str(brand_id), model_name.lower())
            if pair in model_key_pairs:
                errors.append(f"models: duplicate brand/modelName: {brand_id} / {model_name}")
            model_key_pairs.add(pair)
        if item.get("source") not in ALLOWED_SOURCES:
            errors.append(f"models: invalid source for {model_id}: {item.get('source')}")

    alias_pairs: set[tuple[str, str]] = set()
    for item in loaded["aliases"].get("items", []):
        if not isinstance(item, dict):
            errors.append("aliases: item must be object")
            continue
        model_id = item.get("modelId")
        alias = item.get("alias")
        if model_id not in model_ids:
            errors.append(f"aliases: modelId not found: {model_id}")
        errors.extend(validate_alias_value(f"aliases:{model_id}", alias))
        if isinstance(alias, str) and alias:
            pair = (str(model_id), alias.strip().lower())
            if pair in alias_pairs:
                errors.append(f"aliases: duplicate alias for {model_id}: {alias}")
            alias_pairs.add(pair)

    keyword_pairs: set[tuple[str, str]] = set()
    for item in loaded["keywords"].get("items", []):
        if not isinstance(item, dict):
            errors.append("search_keywords: item must be object")
            continue
        model_id = item.get("modelId")
        keyword = item.get("keyword")
        if model_id not in model_ids:
            errors.append(f"search_keywords: modelId not found: {model_id}")
        errors.extend(validate_keyword_value(f"search_keywords:{model_id}", keyword))
        if isinstance(keyword, str) and keyword:
            pair = (str(model_id), keyword.strip().lower())
            if pair in keyword_pairs:
                errors.append(f"search_keywords: duplicate keyword for {model_id}: {keyword}")
            keyword_pairs.add(pair)

    return errors, brand_ids, model_ids


def validate_proposal_file(path: Path, existing_brand_ids: set[str], existing_model_ids: set[str]) -> list[str]:
    errors: list[str] = []
    data = load_json(path)
    name = f"proposal:{path.name}"

    required = ["version", "createdAt", "scope", "status", "brands", "models", "aliases", "searchKeywords", "audit"]
    for key in required:
        if key not in data:
            errors.append(f"{name}: missing {key}")

    if not isinstance(data.get("createdAt"), str) or not DATE_PATTERN.match(data.get("createdAt", "")):
        errors.append(f"{name}: createdAt must be YYYY-MM-DD")
    if data.get("status") not in ALLOWED_PROPOSAL_STATUS:
        errors.append(f"{name}: invalid status: {data.get('status')}")

    proposed_brand_ids = set(existing_brand_ids)
    proposed_model_ids = set(existing_model_ids)

    brands = data.get("brands", [])
    models = data.get("models", [])
    aliases = data.get("aliases", [])
    keywords = data.get("searchKeywords", [])

    if not isinstance(brands, list):
        errors.append(f"{name}: brands must be array")
        brands = []
    if not isinstance(models, list):
        errors.append(f"{name}: models must be array")
        models = []
    if not isinstance(aliases, list):
        errors.append(f"{name}: aliases must be array")
        aliases = []
    if not isinstance(keywords, list):
        errors.append(f"{name}: searchKeywords must be array")
        keywords = []

    for brand in brands:
        if not isinstance(brand, dict):
            errors.append(f"{name}: brand item must be object")
            continue
        brand_id = brand.get("brandId")
        if not isinstance(brand_id, str) or not ID_PATTERN.match(brand_id):
            errors.append(f"{name}: invalid proposed brandId: {brand_id}")
            continue
        if brand_id in existing_brand_ids:
            errors.append(f"{name}: proposed brand already exists: {brand_id}")
        proposed_brand_ids.add(brand_id)
        if brand.get("tier") not in ALLOWED_TIERS:
            errors.append(f"{name}: invalid proposed tier for {brand_id}: {brand.get('tier')}")
        if not isinstance(brand.get("isEnabled"), bool):
            errors.append(f"{name}: proposed isEnabled must be boolean for {brand_id}")

    for model in models:
        if not isinstance(model, dict):
            errors.append(f"{name}: model item must be object")
            continue
        model_id = model.get("id")
        brand_id = model.get("brandId")
        if not isinstance(model_id, str) or not ID_PATTERN.match(model_id):
            errors.append(f"{name}: invalid proposed model id: {model_id}")
            continue
        if model_id in existing_model_ids:
            errors.append(f"{name}: proposed model already exists: {model_id}")
        proposed_model_ids.add(model_id)
        if brand_id not in proposed_brand_ids:
            errors.append(f"{name}: proposed model brandId not found: {model_id} / {brand_id}")
        if not isinstance(model.get("modelName"), str) or not model.get("modelName"):
            errors.append(f"{name}: proposed modelName required for {model_id}")
        if model.get("source") not in ALLOWED_SOURCES:
            errors.append(f"{name}: invalid proposed source for {model_id}: {model.get('source')}")

    proposal_alias_pairs: set[tuple[str, str]] = set()
    for alias_item in aliases:
        if not isinstance(alias_item, dict):
            errors.append(f"{name}: alias item must be object")
            continue
        model_id = alias_item.get("modelId")
        alias = alias_item.get("alias")
        if model_id not in proposed_model_ids:
            errors.append(f"{name}: alias modelId not found: {model_id}")
        errors.extend(validate_alias_value(f"{name}:alias:{model_id}", alias))
        if isinstance(alias, str) and alias:
            pair = (str(model_id), alias.strip().lower())
            if pair in proposal_alias_pairs:
                errors.append(f"{name}: duplicate proposed alias for {model_id}: {alias}")
            proposal_alias_pairs.add(pair)

    proposal_keyword_pairs: set[tuple[str, str]] = set()
    for keyword_item in keywords:
        if not isinstance(keyword_item, dict):
            errors.append(f"{name}: keyword item must be object")
            continue
        model_id = keyword_item.get("modelId")
        keyword = keyword_item.get("keyword")
        if model_id not in proposed_model_ids:
            errors.append(f"{name}: keyword modelId not found: {model_id}")
        errors.extend(validate_keyword_value(f"{name}:keyword:{model_id}", keyword))
        if isinstance(keyword, str) and keyword:
            pair = (str(model_id), keyword.strip().lower())
            if pair in proposal_keyword_pairs:
                errors.append(f"{name}: duplicate proposed keyword for {model_id}: {keyword}")
            proposal_keyword_pairs.add(pair)

    audit = data.get("audit")
    if not isinstance(audit, dict):
        errors.append(f"{name}: audit must be object")
    else:
        if audit.get("risk") not in ALLOWED_RISK:
            errors.append(f"{name}: invalid audit risk: {audit.get('risk')}")
        if not isinstance(audit.get("notes"), list):
            errors.append(f"{name}: audit notes must be array")

    return errors


def validate() -> list[str]:
    errors, brand_ids, model_ids = validate_master_data()

    if PROPOSALS.exists():
        for path in sorted(PROPOSALS.glob("*.json")):
            errors.extend(validate_proposal_file(path, brand_ids, model_ids))

    return errors


def main() -> int:
    try:
        errors = validate()
    except ValueError as e:
        print(f"ERROR: {e}")
        return 1

    if errors:
        print("Kick×Kick data validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print("Kick×Kick data validation passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
