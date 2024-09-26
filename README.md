<div align="center">
<a href="https://github.com/COSSAS/SOARCA"><img src="img/soarca-logo.svg"/></a>
</div>


# soarca-one-conference-2024

This Repository contains all the files for the One Conference talk on: [**SOARCA: open-source SOAR for CACAO playbook automation**](https://one-conference.nl/session/soarca-open-source-soar-for-cacao-playbook-automation/). An open-source security orchestration and automation tool using the [CACAO security playbook format](https://docs.oasis-open.org/cacao/security-playbooks/v2.0/security-playbooks-v2.0.html). 


## Abstract of Talk

In an ever-changing landscape of organisational cybersecurity, resilience has become of imperative importance. To be better equipped against threat actors and their increasingly more complex tactics, techniques and procedures, organisations must actively engage in the detection, investigation, prevention, mitigation, and remediation of cyber threats in a timely manner. To accomplish this, organisations are increasingly automating threat and incident response via playbook driven approaches. Security playbooks maintain case-specific sequences of actions, workflows, that can detail the execution of security procedures, for instance a response of a detected phishing email, or a compromised asset. These workflows can be expressed in a machine-readable format, and are typically executed by a Security Orchestration, Automation and Response (SOAR) tool. Normally, SOAR tools employ proprietary and closed playbook formats, which strongly limit cybersecurity interoperability and information sharing among different tools, and organisations, thus reducing overall cybersecurity posture. The CACAO playbook format, developed by OASIS Open, introduces a standardised definition of security playbooks, hence advancing the state-of-play in this field.

In this technical talk, we will present, Security Orchestrator for Advanced Response to Cyber Attacks (SOARCA), a TNO developed open-source SOAR , SOARCA is the first open-source SOAR tool to adopt the open CACAO playbook standard. In particular, SOARCA can execute CACAO cybersecurity playbooks for both defensive, as well as offensive, workflows. During the session we will take a technical deep dive by demonstrating the automation capabilities of SOARCA through two hands-on use-cases.

First, we will showcase its automation capabilities in countering an advanced phishing attack targeting a representative organisation. This will encompass the entire process, from detecting a phishing campaign, to effectively resolving such threats through the use of [CACAO playbooks](https://docs.oasis-open.org/cacao/security-playbooks/v2.0/security-playbooks-v2.0.html) and their execution via SOARCA.

Secondly, we will demonstrate how SOARCA executes a CACAO playbook to remediate malware-infected assets within an organisation. This highlights how CACAO and SOARCA can not only enhance investigative capabilities and recovery time, but also fully automate security procedures. This helps in greatly enhancing the efficiency of recurrent security operations within organisations.

Furthermore, we will delve into the inner workings of our platform, illustrating how the orchestration and automation capabilities of SOARCA can be tailored to meet specific requirements using our SOARCA Fin library , enabling creation of custom functionalities in Python to effectively address unique security challenges.

## Questions

If you have any questions please feel free to reach out to our [slack channel](https://join.slack.com/t/cossas/shared_invite/zt-2i4zxg0oh-dhhL4zTSX5olysngrPxDkg), or open a gitHub [issue](https://github.com/thecyberproject/one-conference-2024/issues).

## Project Tree

```bash
.
├── README.md
├── ansible //ansibles used for configuring
├── docker //docker for running soarca stack
├── img //meta data
├── scenario_files //scenario files for phising attack demo use-case
├── slides //slides used during presentation
└── terraform //terraforms for automatic deployment
```
