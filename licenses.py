import json
import csv
import requests


def convert_package_resolved_to_csv(package_resolved_path, csv_output_path):
    with open(package_resolved_path, "r") as file:
        package_resolved_data = json.load(file)

    packages = package_resolved_data.get("object", {}).get("pins", [])

    with open(csv_output_path, "w", newline="") as csvfile:
        fieldnames = ["Module", "License", "Repository"]
        csv_writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        csv_writer.writeheader()

        for package in packages:
            package_name = package.get("package")
            repository_url = package.get("repositoryURL")
            version = package.get("state", {}).get("version")

            if package_name and repository_url:
                csv_writer.writerow(
                    {
                        "Module": f"{package_name}:{version}",
                        "License": get_github_repo_license(repository_url),
                        "Repository": repository_url,
                    }
                )


def normalize_github_repo_url(github_repo_url):
    # Remove the '.git' extension if present
    if github_repo_url.endswith(".git"):
        github_repo_url = github_repo_url[:-4]

    # Ensure the URL ends with '/'
    if not github_repo_url.endswith("/"):
        github_repo_url += "/"

    return github_repo_url


def get_github_repo_license(github_repo_url):
    github_repo_url = normalize_github_repo_url(github_repo_url)

    # Extract the owner and repo name from the GitHub URL
    _, owner, repo = github_repo_url.rstrip("/").rsplit("/", 2)[-3:]

    # GitHub API endpoint for license information
    api_url = f"https://api.github.com/repos/{owner}/{repo}/license"

    try:
        # Make a GET request to the GitHub API
        response = requests.get(api_url)
        response.raise_for_status()

        # Parse the JSON response
        license_data = response.json()

        # Check if the repository has a license
        if "license" in license_data:
            return license_data["license"]["spdx_id"]
        else:
            return None

    except requests.exceptions.RequestException as e:
        print(f"Error fetching license information: {e}")
        return None


# Example usage
github_repo_url = "https://github.com/example/example-repo"
license_type = get_github_repo_license(github_repo_url)

if __name__ == "__main__":
    package_resolved_path = "Package.resolved"
    csv_output_path = "licenses.csv"

    convert_package_resolved_to_csv(package_resolved_path, csv_output_path)
