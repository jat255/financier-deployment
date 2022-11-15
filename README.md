*Note:* this is a modified version of https://gitlab.com/josh-whitney/financier-backend
that is slightly restructured and updated to work with the latest version of Financier
(as of Nov. 2022)

# Quick Start
Download or clone the repository. By default, the script will use the most recent
version of Financier published at https://github.com/financier-io/financier.git.
If you wish to change this (such as to your own fork or a different branch) change
the `GIT_REF` variable in the `.env` file to a different URL.

If you want to use the mobile version of the app 
(built by @asromzek - see https://gitlab.com/asromzek/fmobile), then make
sure to run the following before building the other Docker images below:

```
./build_fmobile.sh
```

Once you have done this, run the following commands. You can modify the 
`create_certs.sh` script if you'd like to make changes to how the certificates
are generated, but the defaults should be sufficient unless you are using 
a different IP address:

```
docker-compose run --rm generate_ssl_certs sh ./create_certs.sh
docker-compose build
docker-compose up -d
```

Then navigate to `https://localhost` (or the server's IP) in your favorite browser to
start using Financier. The Financier mobile app should be available at `https://localhost/mobile`.

Run

```
docker-compose down
```
to shut Financier down.

Run 

```
docker-compose logs --follow
```
to see the logs from the deployment stack as they are produced (Ctrl-C will quit the log viewer)

When you're restarting Financier again in the future you only need to run
`docker-compose up -d`, there's no need to build the images or create
the certs again.

# Detailed Instructions
The above steps will get Financier up and running locally in a Dockerized
application, with a persistent local CouchDB to store your budget data.  This
is a detailed explanation of each step.

0. Make sure you have Docker and `docker-compose` installed
1. Download the file `docker-compose.yml` from this repo (or you can just clone
   or download the whole repo).  Save the file to a directory where you want
   your budgets to be stored (the budgets will be stored in the subdirectory 
   `financier-backend/couchdb_data` that will be automatically created for you later).
2. `cd` into the directory where `docker-compose.yml` is stored and run
   `git clone https://github.com/financier-io/financier.git financier-frontend` to download
   the latest Financier sources.  You could also download a fork and perhaps change to a different
   branch at this step, if desired.
3. Run `docker-compose build` to build the various Docker images specificied in the compose file
4. *You only ever need to run this step once to generate keys, if you're just restarting
   Financier it's not necessary.*  
   If you don't have your own SSL certificate (if you don't know what this means you
   don't have one), run `docker-compose run --rm generate_ssl_certs sh ./create_certs.sh`.
   This will generate a self-signed SSL certificate and key in the subdirectory `secrets`
   that will be used to enable https on your local Financier. Prior to running this script,
   you can modify the contents of `create_certs.sh`, which you may want to do if you're running
   on a different DNS name or IP address (add the correct hostname to the `subjectAltName` line). 
   If you have your own keys/cert, just make the subdirectory `secrets` yourself and
   move your key and cert file there.  Make sure they're named `site.key` and `site.crt`.
5. Run `docker-compose up -d`. This will start the Financier server in
   the background.
6. Navigate your favorite modern browser to `localhost`.  You can now use Financier
   like you normally would.  Create users, perform your budgeting tasks, etc.  Billing
   flows won't work but it won't matter for a local install that you and your family will use.  
   Note that we're using self-signed certificates, so your browser will
   probably complain that the host is unknown/insecure.  Most browsers have a way
   to allow `localhost` to have a self-signed certificate.  In Chrome, for example,
   paste `chrome://flags/#allow-insecure-localhost`
   into the address bar and then click 'enable' on 'allow invalid certificates for resources 
   loaded from localhost.'  Or see 
   [this](https://stackoverflow.com/questions/7580508/getting-chrome-to-accept-self-signed-localhost-certificate) 
   Stack Overflow thread. See 
   [here](https://improveandrepeat.com/2016/09/allowing-self-signed-certificates-on-localhost-with-chrome-and-firefox/)
   for Firefox.
8. When you want to shut down your Financier server, simply run `docker-compose down`
   and the app will be shutdown and all the containers deleted.  Your budget data
   will remain and be available the next time you start Financier as long as you
   don't delete `couchdb_data`.

# Database Password
By default, the above instructions run CoucbDB in [admin party mode](https://docs.couchdb.org/en/stable/intro/security.html).  
To avoid this, you can place a file called `admin_password.txt` in the `secrets`
subdirectory that was created above.  After you create that file, running Financier
as above will automatically set the CouchDB admin password to the value in that
file and use it for future username creation.
