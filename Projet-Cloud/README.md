# Projet Cloud — Floci et Terraform

**Classe :** DIC2-GIT  
**Module :** Cloud & DevOps  
**Auteur :** Médoune DIOP  
**Professeur :** M. Ibrahima MBENGUE  

---

## 1. Présentation du projet

Ce projet a pour objectif de déployer des services Cloud en local à l'aide de **Floci** (émulateur d'APIs Cloud) et de piloter leur cycle de vie complet avec **Terraform**. Les ressources créées sont explorées et vérifiées visuellement via la console web **Floci UI**.

---

## 2. Choix du Provider et des Services

* **Provider Cloud :** `AWS` (Amazon Web Services)
* **Services Cloud retenus :**
  1. **Amazon S3 (Simple Storage Service)** : service de stockage objet (création d'un bucket avec versioning activé).
  2. **AWS Secrets Manager** : service de coffre-fort numérique pour la gestion sécurisée des secrets applicatifs (clés d'API, identifiants de base de données).

### Justification du choix
L'association de S3 et de Secrets Manager répond à une architecture applicative classique et sécurisée :
- **Sécurité et conformité (DevSecOps) :** Au lieu de stocker des mots de passe ou des clés d'API en dur dans le code ou les fichiers de configuration, ces données sensibles sont centralisées et chiffrées dans Secrets Manager.
- **Séparation des responsabilités :** Le bucket S3 gère le stockage des données et fichiers non structurés, tandis que Secrets Manager fournit les credentials d'accès.
- **Support local complet :** Ces deux services sont parfaitement pris en charge par Floci et visualisables immédiatement dans Floci UI.

---

## 3. Compréhension : Endpoint local vs Cloud réel

| Critère | Cloud AWS Réel | Floci en Local |
| :--- | :--- | :--- |
| **Endpoint** | URLs publiques AWS (ex: `s3.us-east-1.amazonaws.com`) | URL locale (`http://localhost:4566`) |
| **Authentification** | Clés IAM réelles, signature SigV4 validée par AWS | Identifiants factices (`mock_access_key`), validation désactivée |
| **Coût & Facturation** | Payant à l'usage | 100 % gratuit |
| **Réseau** | Connexion Internet obligatoire | Fonctionnement autonome hors-ligne sur la machine |

Dans Terraform, la redirection s'opère dans le fichier `providers.tf` via le bloc `endpoints`.

---

## 4. Structure du Répertoire

```text
Projet-Cloud/
├── README.md              # Documentation du projet
├── docker-compose.yml      # Lancement de Floci et de Floci UI
├── versions.tf             # Définition des versions Terraform et provider AWS
├── providers.tf            # Provider AWS configuré sur l'endpoint Floci local
├── variables.tf            # Variables d'entrée avec validations
├── terraform.tfvars        # Valeurs assignées aux variables
├── locals.tf               # Préfixes de nommage et tags communs
├── main.tf                 # Instanciation des modules S3 et Secrets Manager
├── outputs.tf              # Outputs globaux exposés
├── .gitignore              # Exclusion des fichiers temporaires Terraform
├── modules/
│   ├── s3/
│   │   ├── main.tf         # Définition du bucket S3 et du versioning
│   │   ├── variables.tf    # Variables du module S3
│   │   └── outputs.tf      # ID et ARN du bucket
│   └── secrets_manager/
│       ├── main.tf         # Secret et secret_version au format JSON
│       ├── variables.tf    # Variables du module Secrets Manager
│       └── outputs.tf      # ID, ARN et nom du secret
└── screenshots/
    ├── floci.png           # Floci actif dans le terminal
    ├── floci-ui.png        # Console Web Floci UI
    ├── resources.png       # Ressources S3 et Secrets Manager créées
    └── destroy.png         # Console après destruction des ressources
```

---

## 5. Guide d'Exécution

### 1. Démarrage de Floci et Floci UI
Lancer les conteneurs avec Docker Compose :
```bash
docker compose up -d
```

Vérifier que les conteneurs fonctionnent :
```bash
docker compose ps
```

* Endpoint API Floci : `http://localhost:4566`
* Console Floci UI : `http://localhost:4500`

### 2. Déploiement avec Terraform
Initialiser le répertoire et télécharger le provider AWS :
```bash
terraform init
```

Vérifier le formatage et la syntaxe :
```bash
terraform fmt -check
terraform validate
```

Générer et visualiser le plan d'exécution :
```bash
terraform plan
```

Déployer les ressources :
```bash
terraform apply -auto-approve
```

### 3. Vérification des ressources
Accéder à Floci UI sur `http://localhost:4500` :
- Dans la section **Storage**, observer le bucket `cloud-project-dev-data-bucket`.
- Dans la section **Secrets Manager**, observer le secret `cloud-project-dev-app-secrets` et ses valeurs.

### 4. Destruction des ressources
Supprimer toutes les ressources gérées par Terraform :
```bash
terraform destroy -auto-approve
```

Vérifier dans Floci UI que les ressources ont bien disparu.

Pour arrêter l'environnement Floci :
```bash
docker compose down
```
