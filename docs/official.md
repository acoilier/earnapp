# Documentation officielle

## But du projet

Ce projet fournit une image Docker EarnApp maintenue avec une priorité forte sur:
- la transparence
- la reproductibilité
- la sécurité relative de la chaîne de build
- la clarté sur le rôle du parrainage

## Ce que fait l’image

- télécharge le script d’installation publié par BrightData pour EarnApp
- vérifie le script via SHA256 avant exécution
- installe EarnApp dans le container
- persiste l’état dans `/etc/earnapp`
- limite les privilèges du container au strict nécessaire

## Transparence sur le parrainage

Cette image peut intégrer un code de parrainage du mainteneur dans le flux d’enregistrement.

Cela doit être indiqué clairement et visiblement aux utilisateurs.

Formulation recommandée dans le README public:
- "Ce dépôt peut injecter un code de parrainage du mainteneur dans le processus d’enregistrement EarnApp."
- "L’exécution de l’image peut conduire à l’attribution d’un parrainage au mainteneur."
- "Le code exact et son mode d’injection doivent être documentés publiquement."

## Bonnes pratiques publiques

- éviter `latest` dans les instructions d’usage
- documenter la version du script téléchargé et son hash
- expliquer la provenance du script d’installation
- expliquer les limites de sécurité de la solution
- fournir une procédure d’audit simple
- publier un `.env.example` avec les variables attendues

## Message à faire apparaître publiquement

Le projet doit rester honnête sur son fonctionnement:
- l’image n’est pas un binaire officiel d’EarnApp
- elle s’appuie sur un install script tiers
- un mécanisme de parrainage peut être présent
- l’utilisateur doit pouvoir comprendre ce qui est fait au moment de l’exécution

## Livrables publics attendus

- `README.md` clair
- `Dockerfile` documenté
- `docker-compose.yml` minimal
- `.env.example`
- une section "sécurité et limites" dans la doc
