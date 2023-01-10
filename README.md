# Vercel Deployment Action

This action uses the current branch, awaits for the vercel deployment to be complete and outputs it. This can be used to run automation tests

## Inputs

## `token`

**Required** This is the gitub token.

## Outputs

## `preview_url`

Users to pass as a paramater into automation tests.

## Example usage

uses: actions/vercel-deployment-action@v2
with:
  token: ${{ secrets.GITHUB_TOKEN }}