# This is the common file for all the duplicate codes in this project.

PRINT (){
  echo ""

}

#Usually MongoDB opens the port only to localhost(127.0.0.1), meaning this service can be accessed by the
# application that is hosted on this server only. However, we need to access this service to be accessed by another server,
# So we need to change the config accordingly.

# Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf

