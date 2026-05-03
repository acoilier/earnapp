# earnapp-safe

Image Docker EarnApp construite avec une approche prudente: provenance documentée, script d'installation épinglé par SHA256, CI/CD GitHub Actions, scan de vulnérabilités et publication automatisée sur Docker Hub.

Important: ce dépôt n'est pas officiel EarnApp/BrightData. Il encapsule le script Linux public d'EarnApp dans une image plus contrôlée, mais il reste dépendant d'un installateur tiers.

## Objectifs

- éviter les images EarnApp publiques non auditées
- vérifier le script officiel avant utilisation
- publier une image multi-architecture amd64/arm64 sur Docker Hub
- détecter automatiquement les changements du script upstream
- documenter clairement les limites et le fonctionnement
- garder les secrets et notes privées hors du dépôt public

## Fonctionnement

L'image télécharge le script suivant pendant le build:

https://brightdata.com/static/earnapp/install.sh

Hash SHA256 actuellement épinglé:

ff6647905a43245bac71edce3d3a49bab72e0ef5a17c6a42fdebe2c14b37261e

Si ce hash change, la CI échoue et le workflow `upstream-check` ouvre une issue pour forcer un audit manuel avant mise à jour.

## Utilisation locale

Copier l'exemple d'environnement:

```bash
cp .env.example .env
```

Lancer:

```bash
docker compose up -d --build
```

Consulter les logs:

```bash
docker logs -f earnapp
```

Arrêter:

```bash
docker compose down
```

## Variables

- `EARNAPP_UUID`: optionnel, permet de restaurer une identité de noeud si le flux EarnApp l'accepte.
- `EARNAPP_REFERRAL_CODE`: optionnel, variable exposée pour la transparence. Le support exact dépend du flux officiel EarnApp.
- `EARNAPP_INSTALL_URL`: URL du script d'installation.
- `EARNAPP_INSTALL_SHA256`: hash attendu du script d'installation.

## Publication Docker Hub

Le workflow `.github/workflows/publish.yml` publie l'image quand:

- un tag `vX.Y.Z` est poussé
- une release GitHub est publiée
- le workflow est lancé manuellement

Secrets GitHub requis:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

Image cible par défaut:

```text
acoilier/earnapp
```

## CI/CD

Workflows inclus:

- `ci.yml`: vérifie le hash upstream, valide Docker Compose, build l'image, scan Trivy.
- `publish.yml`: build multi-architecture, SBOM/provenance BuildKit, push Docker Hub.
- `upstream-check.yml`: vérifie chaque jour si le script officiel a changé et ouvre une issue si audit nécessaire.
- `dependabot.yml`: met à jour les GitHub Actions et la base Docker.

## Sécurité et limites

Ce projet améliore la chaîne de build, mais ne rend pas EarnApp intrinsèquement sans risque.

Mesures appliquées:

- hash SHA256 obligatoire du script d'installation
- pas de `curl | bash` non vérifié
- CI bloquante si le script upstream change
- image scannée avant publication
- publication par tags/releases plutôt que publication manuelle opaque
- état persistant isolé dans `/etc/earnapp`
- capabilities Docker supprimées autant que possible dans `docker-compose.yml`

Limites:

- le script EarnApp peut télécharger d'autres artefacts pendant l'installation
- le flux d'enregistrement/parrainage n'est pas entièrement documenté publiquement
- le conteneur peut nécessiter plus de privilèges selon les changements upstream
- Trivy ne détecte pas tous les risques logiques ou comportementaux

## Audit manuel quand le hash change

1. Télécharger l'ancien et le nouveau script.
2. Comparer le diff.
3. Vérifier les URLs, binaires, commandes système et télémétrie.
4. Tester le build localement.
5. Mettre à jour le hash dans:
   - `Dockerfile`
   - `.env.example`
   - `Makefile`
   - `.github/workflows/ci.yml`
   - `.github/workflows/publish.yml`
6. Créer un tag/release pour publier.

## Transparence parrainage

Si un code de parrainage est utilisé, il doit être documenté clairement dans la page Docker Hub et dans ce README. L'utilisateur doit savoir qu'un mécanisme de parrainage peut être présent avant d'exécuter l'image.

## Notes privées

`docs/private.md` est ignoré par Git et ne doit pas être publié.
