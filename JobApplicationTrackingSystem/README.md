# Enterprise Recruitment Management System

A Salesforce-based Recruitment Management System built using Apex, SOQL, Triggers, Async Apex, Approval Processes, Batch Apex, Reports, and Dashboards.

This project simulates a real-world recruitment workflow where companies can manage job openings, candidates, interviews, approvals, and hiring analytics through automated Salesforce processes.

---

# Features

## Candidate Management
- Store candidate information
- Track skills and experience
- Maintain candidate hiring status

---

## Job Opening Management
- Manage job positions
- Track department-wise openings
- Define required experience

---

## Job Application Tracking
- Candidates can apply for multiple jobs
- Tracks application lifecycle
- Implements many-to-many relationship architecture

---

# Recruitment Workflow Automation

## Automatic Candidate Screening

When a candidate applies:
- If candidate experience matches required experience:
  - Status becomes `Screening`
- Otherwise:
  - Status becomes `Rejected`

Implemented using:
- Apex Trigger
- Trigger Handler Pattern
- Cross-object SOQL
- Bulkified Logic

---

## Interview Scheduling Automation

When application status becomes:
```text
Interview Scheduled