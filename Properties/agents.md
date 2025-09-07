name: Copilot Multi-Agent Matrix

on:
  issues:
    types: [opened, labeled]

jobs:
  multi-agent:
    strategy:
      matrix:
        role: [unit_test_creator, appservice_migration_assessor]
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Run Copilot Coding Agent with role
        run: |
          echo "Triggering Copilot for role: ${{ matrix.role }}"
          
          # Role-based instruction for Copilot
          if [ "${{ matrix.role }}" == "unit_test_creator" ]; then
            ROLE_PROMPT="You are a Unit Test Creator. Please generate comprehensive xUnit tests for the code in this repository. Include positive, negative, and edge cases."
          elif [ "${{ matrix.role }}" == "appservice_migration_assessor" ]; then
            ROLE_PROMPT="You are a Migration Assessor. Please analyze this repository for migration readiness to Azure App Service. Identify dependencies, configuration changes, and provide a migration checklist."
          fi

          # Add comment to issue to trigger Copilot Coding Agent
          gh issue comment ${{ github.event.issue.number }} \
            --body "/assign @copilot\n\n${ROLE_PROMPT}"

        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
