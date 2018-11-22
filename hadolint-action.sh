#!/bin/sh
set -e
cd "${HADOLINT_ACTION_DOCKERFILE_FOLDER:-.}"

if [ "$HADOLINT_ACTION_COMMENT" = "1" ] || [ "$HADOLINT_ACTION_COMMENT" = "false" ]; then
    exit $SUCCESS
fi

DOCKERFILE="$HADOLINT_ACTION_DOCKERFILE_FOLDER/Dockerfile"
HADOLINT_VIOLATIONS="$(hadolint $DOCKERFILE)"

COMMENT="#### \`hadolint\` Failed

<details><summary><code>"$DOCKERFILE"</code></summary>

\`\`\`
hadolint violations:
$HADOLINT_VIOLATIONS
\`\`\`
</details>
"

PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(cat /github/workflow/event.json | jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS
