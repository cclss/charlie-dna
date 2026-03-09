#!/usr/bin/env bash
set -euo pipefail

# charlie-dna release script
# Usage: ./scripts/release.sh vX.Y.Z [--dry-run]
#
# 하는 일: 검증 → 태그 → 푸시. 끝.
# GitHub Release는 CI(.github/workflows/release.yml)가 자동 생성한다.

VERSION="${1:-}"
DRY_RUN=false

if [[ "${2:-}" == "--dry-run" ]] || [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  if [[ "${1:-}" == "--dry-run" ]]; then
    VERSION="${2:-}"
  fi
fi

# --- Validation ---

if [[ -z "$VERSION" ]]; then
  echo "Usage: ./scripts/release.sh vX.Y.Z [--dry-run]"
  exit 1
fi

if [[ ! "$VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: version must be semver format (vX.Y.Z), got: $VERSION"
  exit 1
fi

if git tag -l "$VERSION" | grep -q "$VERSION"; then
  echo "Error: tag $VERSION already exists"
  exit 1
fi

# --- CHANGELOG check ---

CHANGELOG="CHANGELOG.md"
VERSION_NO_V="${VERSION#v}"

if ! grep -q "## $VERSION" "$CHANGELOG" && ! grep -q "## v$VERSION_NO_V" "$CHANGELOG"; then
  echo "Error: $CHANGELOG has no section for $VERSION"
  echo "Add a section like: ## $VERSION — YYYY-MM-DD"
  exit 1
fi

# --- Preview ---

NOTES=$(awk "/^## $VERSION/{found=1; next} /^## v[0-9]/{if(found) exit} found" "$CHANGELOG")
if [[ -z "$NOTES" ]]; then
  NOTES=$(awk "/^## v$VERSION_NO_V/{found=1; next} /^## v[0-9]/{if(found) exit} found" "$CHANGELOG")
fi

echo "=== Release: $VERSION ==="
echo ""
echo "Release notes (CI will use this for GitHub Release):"
echo "$NOTES"
echo ""

if [[ "$DRY_RUN" == true ]]; then
  echo "[dry-run] Would create tag: $VERSION"
  echo "[dry-run] Would push: origin master --tags"
  echo "[dry-run] CI would then create GitHub Release automatically."
  exit 0
fi

# --- Tag and push ---

echo "Creating tag $VERSION..."
git tag "$VERSION"

echo "Pushing to origin..."
git push origin master --tags

echo ""
echo "Done. CI will create GitHub Release automatically."
echo "https://github.com/cclss/charlie-dna/releases"
