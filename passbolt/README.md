References

    https://help.passbolt.com/hosting/install/ce/docker.html

Notes

Passbolt container runs as specific user with a UID and GUID of 33.

Therefore, ensure proper permissions on the Docker data bind mount volumes:

sudo chgrp 33 /docker/passbolt/gpg
sudo chmod 770 /docker/passbolt/gpg

sudo chgrp 33 /docker/passbolt/jwt
sudo chmod 770 /docker/passbolt/jwt

After spawning up the container, you have to create your user account first. Please follow the referenced link above, which leads you to the official documentation and how-tos. It is also recommended to add SMTP into the mix to retrieve important emails.