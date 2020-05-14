#!/bin/sh
set -e

DOCKERFILE="${HADOLINT_ACTION_DOCKERFILE_FOLDER:-.}/Dockerfile"
FALSE="false"

set +e
HADOLINT_VIOLATIONS=$(sh -c "hadolint $DOCKERFILE" 2>&1)
SUCCESS=$?
echo "$HADOLINT_VIOLATIONS"
set -e

if [ $SUCCESS -eq 0 ]; then
    exit 0
fi

if [ "$HADOLINT_ACTION_COMMENT" -eq 0 ] || [ "${HADOLINT_ACTION_COMMENT,,}" = "${FALSE,,}" ]; then
    exit $SUCCESS
fi

COMMENT="#### \`hadolint\` Failed
<details><summary><code>'$DOCKERFILE'</code></summary>
<p>

\`\`\`markdown
hadolint violations:  
$HADOLINT_VIOLATIONS  
\`\`\`

</p>
</details>
"

PAYLOAD=$(echo '{}' | jq --arg body "$COMMENT" '.body = $body')
COMMENTS_URL=$(< /github/workflow/event.json jq -r .pull_request.comments_url)
curl -s -S -H "Authorization: token $GITHUB_TOKEN" --header "Content-Type: application/json" --data "$PAYLOAD" "$COMMENTS_URL" > /dev/null

exit $SUCCESS
