<a id="readme-top"></a>

[![Website](https://img.shields.io/website-up-down-green-red/http/shields.io.svg?style=for-the-badge)](https://ethanr.uk)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/ethanr-2000/ethanr.co.uk/on.pr.merge.run-cd.yml?branch=main&style=for-the-badge)
![GitHub Release](https://img.shields.io/github/v/release/ethanr-2000/ethanr.co.uk?style=for-the-badge)
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![project_license][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/ethanr-2000/ethanr.co.uk">
    <img src="packages/website/public/favicon.ico" alt="Logo" width="40">
  </a>

<h3 align="center">ethanr.uk</h3>

  <p align="center">

    Ethan's website and project monorepo.

    You are encouraged to use this as a template for your own projects.

  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#deployment">Deployment</a></li>
      </ul>
    </li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project



### Built With

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-web-services&logoColor=white&style=for-the-badge)](#) [![React][React.js]][React-url]
[![Vite](https://img.shields.io/badge/Vite-646CFF?logo=vite&logoColor=fff&style=for-the-badge)](#)
[![pnpm](https://img.shields.io/badge/pnpm-F69220?logo=pnpm&logoColor=fff&style=for-the-badge)](#) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

## Getting Started

The best way to get started is to build and bundle the project.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* [NodeJS](https://nodejs.org/en)
  
  Using [nvm](https://github.com/nvm-sh/nvm) to manage NodeJS means you can easily match your installed version of Node to what is compatible with this project.
  ```sh
  nvm use 22
  ```
* [pnpm](https://pnpm.io/)
  
  Using corepack to manage pnpm means your version of pnpm will automatically be matched to the version in the `package.json`
  ```sh
  corepack enable
  ```
* [Terraform](https://www.terraform.io/) (deployment only)
  
  This project is built with [tfenv](https://github.com/tfutils/tfenv) and [tfscaffold](https://github.com/tfutils/tfscaffold). Tfenv will match your installed version of Terraform to the version specified in the repository. Tfscaffold is used as a framework for managing remote state in S3 and organising resources and variables.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/ethanr-2000/ethanr.co.uk.git
   ```
1. Install dependencies
   ```sh
   pnpm install
   ```
1. Bundle the project. This should automatically run all lint, test and builds.
   ```sh
   pnpm bundle
   ```


### Deployment

If you have an AWS account [with a registered domain](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html), this project can be deployed to AWS by following the instructions below.

> Important! Deploying this project will incur costs on your AWS account. Before deploying this, ensure you understand each resource that will be created and the cost implications of it.

1. Bundle the project: `pnpm bundle`
2. In `packages/terraform/etc/group_main.tfvars`, change the account ID to your AWS account ID.
3. In `packages/terraform/components/variables`, change the FQDN variable to your domain name.
4. If deploying to a region other than eu-west-2, modify all references to eu-west-2 to the region of your choice.
5. Bootstrap the project:
  ```sh
  packages/terraform/bin/terraform.sh -r eu-west-2 -p er --bootstrap -a apply
  ```
6. Plan the "prod" environment:
  ```sh
  packages/terraform/bin/terraform.sh -t -r eu-west-2 -p er -g main -e prod -c ethanr -a plan
  ```
7. Deploy the "prod" environment:
  ```sh
  packages/terraform/bin/terraform.sh -t -r eu-west-2 -p er -g main -e prod -c ethanr -a apply
  ```

The project should become available at the domain name you provided.

Optionally, you can deploy a dev environment.

1. In AWS, find the [Route53 hosted zone](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/hosted-zones-working-with.html) that was created in the prod deployment.
2. Modify `packages/terraform/etc/env_eu-west-2_dev.tfvars`, changing the hosted zone ID to the one found in step 1.
3. Deploy the "dev" environment:
  ```sh
  packages/terraform/bin/terraform.sh -t -r eu-west-2 -p er -g main -e dev -c ethanr -a apply
  ```


## License

Distributed under the MIT License. See `LICENSE.txt` for more information.


## Contact

Ethan Roberts

Project Link: [https://github.com/ethanr-2000/ethanr.co.uk](https://github.com/ethanr-2000/ethanr.co.uk)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/ethanr-2000/ethanr.co.uk.svg?style=for-the-badge
[contributors-url]: https://github.com/ethanr-2000/ethanr.co.uk/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/ethanr-2000/ethanr.co.uk.svg?style=for-the-badge
[forks-url]: https://github.com/ethanr-2000/ethanr.co.uk/network/members
[stars-shield]: https://img.shields.io/github/stars/ethanr-2000/ethanr.co.uk.svg?style=for-the-badge
[stars-url]: https://github.com/ethanr-2000/ethanr.co.uk/stargazers
[issues-shield]: https://img.shields.io/github/issues/ethanr-2000/ethanr.co.uk.svg?style=for-the-badge
[issues-url]: https://github.com/ethanr-2000/ethanr.co.uk/issues
[license-shield]: https://img.shields.io/github/license/ethanr-2000/ethanr.co.uk.svg?style=for-the-badge
[license-url]: https://github.com/ethanr-2000/ethanr.co.uk/blob/main/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/ethanroberts2000/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[GitHub.com]: https://img.shields.io/badge/GitHub?style=for-the-badge&logo=github&logoColor=white
[GitHub-url]: https://github.com/ethanr-2000/ethanr.co.uk
