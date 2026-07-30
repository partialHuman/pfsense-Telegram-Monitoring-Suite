# Release Process

This document describes the release workflow for the **pfSense Telegram Monitoring Suite**. It covers versioning, branching, testing, release preparation, publishing, and maintenance.

Following a standardized release process ensures every version is stable, documented, and reproducible.

---

# Table of Contents

1. Release Strategy
2. Semantic Versioning
3. Branching Model
4. Development Workflow
5. Release Checklist
6. Testing Requirements
7. Updating Documentation
8. Updating Version Numbers
9. Creating a Release
10. Git Tags
11. GitHub Releases
12. Upgrade Procedure
13. Rollback Procedure
14. Hotfix Releases
15. Maintenance Policy

---

# Release Strategy

The project follows a predictable release cycle:

```
Development
      │
      ▼
 Feature Branches
      │
      ▼
 Develop Branch
      │
      ▼
 Release Candidate
      │
      ▼
 Final Testing
      │
      ▼
 Stable Release
      │
      ▼
 Maintenance
```

---

# Semantic Versioning

The project follows **Semantic Versioning (SemVer)**.

```
MAJOR.MINOR.PATCH
```

Example:

```
1.0.0
```

## Major Release

Increment when:

- Breaking changes
- Large architectural changes
- Incompatible APIs

Example

```
1.0.0

↓

2.0.0
```

---

## Minor Release

Increment when:

- New monitoring modules
- New features
- Backward-compatible enhancements

Example

```
1.2.0

↓

1.3.0
```

---

## Patch Release

Increment when:

- Bug fixes
- Documentation improvements
- Performance optimizations
- Security fixes without breaking compatibility

Example

```
1.3.2

↓

1.3.3
```

---

# Branching Strategy

Recommended Git branches:

```
main

develop

feature/*

bugfix/*

release/*

hotfix/*
```

## main

Contains production-ready code.

---

## develop

Contains completed features awaiting the next release.

---

## feature/*

Used for new functionality.

Example

```
feature/vpn-monitor

feature/dhcp-monitor

feature/service-monitor
```

---

## bugfix/*

Used for non-critical bug fixes.

Example

```
bugfix/firewall-parser
```

---

## release/*

Used to stabilize an upcoming version.

Example

```
release/1.2.0
```

---

## hotfix/*

Used for urgent fixes to production releases.

Example

```
hotfix/1.2.1
```

---

# Development Workflow

```
Create Feature Branch
        │
        ▼
Develop Feature
        │
        ▼
Run Tests
        │
        ▼
Update Documentation
        │
        ▼
Open Pull Request
        │
        ▼
Code Review
        │
        ▼
Merge into develop
        │
        ▼
Release Branch
        │
        ▼
Final Testing
        │
        ▼
Merge into main
```

---

# Release Checklist

Before publishing a release:

- [ ] All monitoring modules tested
- [ ] Telegram notifications verified
- [ ] Cron jobs validated
- [ ] WireGuard monitoring tested
- [ ] Suricata monitoring tested
- [ ] Documentation updated
- [ ] CHANGELOG updated
- [ ] Example configuration files reviewed
- [ ] No secrets committed
- [ ] Version numbers updated

---

# Testing Requirements

Minimum tests before every release:

## Functional Testing

- System monitoring
- VPN monitoring
- Firewall monitoring
- Suricata monitoring
- Service monitoring
- Login monitoring

---

## Configuration Testing

Verify:

- Example configuration files
- Default values
- Missing configuration handling

---

## Notification Testing

Confirm:

- Telegram messages sent
- Formatting correct
- Duplicate alerts prevented

---

## Performance Testing

Measure:

- CPU usage
- Memory usage
- Script execution time

---

# Documentation Updates

Review and update:

```
README.md

CHANGELOG.md

Developer_Guide.md

Monitoring_Modules.md

API_Reference.md
```

Ensure screenshots and flowcharts reflect the current release.

---

# Version Updates

Update version references in:

```
README.md

CHANGELOG.md

Release Notes

GitHub Release
```

Example:

```
Version

1.2.0
```

---

# Creating a Release

Example Git workflow:

```bash
git checkout develop

git pull origin develop

git checkout -b release/1.2.0
```

Finalize changes.

Merge into `main` after testing.

---

# Git Tags

Tag each release.

Example:

```bash
git tag -a v1.2.0 -m "Release version 1.2.0"

git push origin v1.2.0
```

Tags make it easy to identify historical releases.

---

# GitHub Releases

Each GitHub Release should include:

- Version number
- Release date
- Summary of changes
- New features
- Bug fixes
- Known issues
- Upgrade instructions

Example:

```
Version

v1.2.0

Highlights

- Added VPN peer monitoring
- Added DHCP monitoring
- Improved firewall log parsing
- Fixed duplicate notification issue
```

---

# Release Assets

Include:

```
Source Code (ZIP)

Source Code (TAR.GZ)

Documentation

Example Configuration Files
```

---

# Upgrade Procedure

1. Backup existing configuration.
2. Pull the latest release.
3. Review `CHANGELOG.md`.
4. Compare local configuration with updated `.example` files.
5. Replace scripts and libraries.
6. Test monitoring modules.
7. Restart scheduled tasks if required.

---

# Rollback Procedure

If issues are found:

```bash
git checkout v1.1.0
```

Restore the previous release.

Restore configuration backup if necessary.

Retest monitoring modules.

---

# Hotfix Releases

Use hotfix releases for:

- Critical security issues
- Broken monitoring modules
- Notification failures
- Severe bugs

Example:

```
1.2.0

↓

1.2.1
```

Hotfixes should be merged into both `main` and `develop`.

---

# Security During Releases

Before publishing:

- Verify no secrets exist in the repository.
- Scan for hardcoded credentials.
- Confirm `.gitignore` excludes sensitive files.
- Remove temporary debugging code.

---

# Maintenance Policy

| Version | Support Status |
|---------|----------------|
| Latest Stable | ✅ Fully Supported |
| Previous Minor | ✅ Security Fixes |
| Older Releases | ⚠ Limited Support |
| End-of-Life | ❌ Unsupported |

---

# Long-Term Maintenance

Recommended practices:

- Review dependencies regularly.
- Test against supported pfSense versions.
- Update documentation with each release.
- Archive obsolete branches.
- Close completed milestones.

---

# Release Notes Template

```text
## Release vX.Y.Z

### New Features
- Added ...

### Improvements
- Improved ...

### Bug Fixes
- Fixed ...

### Security
- Updated ...

### Documentation
- Added ...

### Upgrade Notes
- ...

### Known Issues
- ...
```

---

# Post-Release Tasks

After publishing:

- Verify GitHub Release assets.
- Announce the release.
- Monitor issue reports.
- Triage bug reports.
- Plan the next milestone.

---

# Related Documentation

- CHANGELOG.md
- CONTRIBUTING.md
- Developer_Guide.md
- API_Reference.md
- Monitoring_Modules.md

---

# Conclusion

Following this release process ensures that every version of the **pfSense Telegram Monitoring Suite** is well-tested, properly documented, and easy for users to upgrade. Consistent versioning and release practices improve maintainability, simplify collaboration, and build confidence in the project's stability.