# Documentation officielle

## But du projet

Ce projet fournit une image Docker EarnApp maintenue avec une priorité forte sur:
- la transparence
- la reproductibilité
- la sécurité relative de la chaîne de build

## Ce que fait l’image

- télécharge le script d’installation publié par BrightData pour EarnApp
- vérifie le script via SHA256 avant exécution
- installe EarnApp dans le container
- persiste l’état dans `/etc/earnapp`
- limite les privilèges du container au strict nécessaire

## Soutien au projet

Les utilisateurs publics sont invités à créer leur compte via ce lien de soutien:

```text
https://earnapp.com/i/R66Mmkmr
```

Ce lien permet de soutenir le projet de maintien de l’image.

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
- l’utilisateur doit pouvoir comprendre ce qui est fait au moment de l’exécution

## Livrables publics attendus

- `README.md` clair
- `Dockerfile` documenté
- `docker-compose.yml` minimal
- `.env.example`
- une section "sécurité et limites" dans la doc
