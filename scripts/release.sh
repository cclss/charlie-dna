#!/usr/bin/env bash
set -euo pipefail

# charlie-dna release script
# Usage: ./scripts/release.sh vX.Y.Z [--dry-run]

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

# --- Extract release notes ---

# Extract the section for this version from CHANGELOG.md
NOTES=$(awk "/^## $VERSION/{found=1; next} /^## v[0-9]/{if(found) exit} found" "$CHANGELOG")
if [[ -z "$NOTES" ]]; then
  NOTES=$(awk "/^## v$VERSION_NO_V/{found=1; next} /^## v[0-9]/{if(found) exit} found" "$CHANGELOG")
fi

echo "=== Release: $VERSION ==="
echo ""
echo "Release notes:"
echo "$NOTES"
echo ""

if [[ "$DRY_RUN" == true ]]; then
  echo "[dry-run] Would create tag: $VERSION"
  echo "[dry-run] Would push: origin master --tags"
  echo "[dry-run] Would create GitHub release"
  exit 0
fi

# --- Tag and push ---

echo "Creating tag $VERSION..."
git tag "$VERSION"

echo "Pushing to origin..."
git push origin master --tags

# --- GitHub Release ---

if command -v gh &> /dev/null; then
  echo "Creating GitHub release..."
  echo "$NOTES" | gh release create "$VERSION" \
    --title "$VERSION" \
    --notes-file -
  echo "Done. https://github.com/cclss/charlie-dna/releases/tag/$VERSION"
else
  echo "gh CLI not found. Tag pushed. Create release manually on GitHub."
  echo "https://github.com/cclss/charlie-dna/releases/new?tag=$VERSION"
fi
