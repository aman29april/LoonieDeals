# README

https://looniedeals.onrender.com/

http://looniedeals.ca

This README would normally document whatever steps are necessary to get the
application up and running.


Start App.
./bin/dev

Local Login URL: http://localhost:3000/users/sign_in

Things you may want to cover:


rake db:purge db:create db:migrate db:seed


docker-compose up --build


### Graph API Explorer
https://developers.facebook.com/tools/explorer/

### Token Debugger
https://developers.facebook.com/tools/debug/accesstoken/


### Update Access Token
```
token = 'latest_value'
SiteSetting.instance.update!(facebook_access_token: token)
```

### Task - Smartcanucks Amazon deals

```
External::Smartcanucks::Amazon.new
```





dokku apps:create looniedeals

dokku postgres:create dealsdatabase
dokku postgres:link dealsdatabase looniedeals


dokku certs:add looniedeals server.crt server.key

dokku config:set --no-restart looniedeals 
DOKKU_LETSENCRYPT_EMAIL=aman29april@gmail.com

dokku letsencrypt looniedeals


dokku domains:add looniedeals looniedeals.ca

git remote add dokku dokku@looniedeals.ca:looniedeals
git push dokku main


# Secrets

rails credentials:edit --environment production
