<h4> 
  This workflow uses a standard Fedora/RHEL container to run the native rpmbuild -bs command, which ensures maximum reliability and compatibility with standard packaging guidelines without relying on unverified third-party marketplace actions.
</h5>

### Key Requirements Checklist
To make this workflow run successfully, ensure your repository contains the following:
- A valid .spec file: Change your-package.spec in the workflow to match your actual filename.
- Matching source names: The tarball filename generated in the "Create source tarball" step must exactly match the Source0 (or Source) tag definition inside your .spec file.

### Workflow Highlights
- Official Container Isolation: Runs natively inside a Fedora Container to guarantee that all macro expansions mimic a real build system.
- Native Tooling: Uses official rpm-build utilities rather than custom scripts.
- Artifact Retention: Automatically saves the resulting .src.rpm file, making it accessible directly from the GitHub Actions run summary page.
