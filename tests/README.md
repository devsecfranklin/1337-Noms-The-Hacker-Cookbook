
## install travis

```
sudo apt-get install  ruby-ffi
sudo gem install travis
travis encrypt MY_SECRET_ENV=my_secret --add env.matrix
```

## setup travis key

https://github.com/alrra/travis-scripts/blob/master/docs/github-deploy-keys.md


## tests

- make sure the .md matches the folder name
- images should have a inline link in markdown
- must pass lint check
- submitter should update credits file
