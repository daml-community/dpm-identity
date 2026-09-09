# Onboarding a New Organisation
## Before Opening
Before opening a PR make sure:

- You have been added as a contributor to the repository via the request mechanism. If not request to be added [here](https://github.com/daml-community/daml-identity/issues/new?template=add-contributor.yml).
- You understand the [file structure](https://daml-community.github.io/daml-identity-docs/repo-structure/files.html).
- You've followed the setup instructions on the wiki to setup a **gpg-agent** and enable gpg signing of commits. If not see here:
    - [Windows](https://daml-community.github.io/daml-identity-docs/repo-structure/setup/windows.html)
    - [macOS](https://daml-community.github.io/daml-identity-docs/repo-structure/setup/macOS.html)
    - [Linux](https://daml-community.github.io/daml-identity-docs/repo-structure/setup/linux.html)

## Writing the PR
1. Check out the repository locally.
2. Create a new branch based off `master`, and commit your organisation's files. 
  As a reminder, an organisation folder should contain:
    - A [`_meta.json`](../repo-structure/files.md#org-metadata) file that specifies metadata about the organisation
    - A collection of [`<person>.json`](../repo-structure/files.md#person-metadata) files and their associated [`<person>.pub`](../repo-structure/files.md#person-public-key) public keys.
3. Push your changes to the remote on a new branch. (Collaborator status is required)
4. Open a PR, and request reviews from **maintainers**
5. When 2 maintainers approve, the PR can be merged.

## Key Information
Please fill out the following details:

```
Organisation Name:
Github username:
Github id:
```

> [!NOTE] A user's GitHub id can easily be found from their username via the following http endpoint:
> ```sh
> curl -s https://api.github.com/users/<username> | jq '.id'
> ```
