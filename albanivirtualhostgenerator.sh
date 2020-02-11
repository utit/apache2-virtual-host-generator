#!bash

##Membuat nama domain
echo Masukan nama domain yang akan dibuat contoh: albani.id !
read namaDomain
if [ -z "$namaDomain" ]; then
	echo STOP...  Proses dihentikan karena kamu nggak nentuin nama domainnya :'('
	exit
fi

sudo mkdir  /var/www/html/$namaDomain
sudo chown -R $USER:$USER /var/www/html/$namaDomain
sudo chmod -R 755 /var/www/html/$namaDomain
echo '<center style="margin-top:50px">Alhamdulillah, kamu berhasil membuat virtual host/domain <b>'.$namaDomain.'</b></center>' >> /var/www/html/$namaDomain/index.html

#eksekusi

sudo tee -a /etc/apache2/sites-available/$namaDomain.conf << EOF
<VirtualHost *:80>
	
	ServerAdmin admin@localhost
	ServerName $namaDomain
	ServerAlias www.$namaDomain
	DocumentRoot /var/www/html/$namaDomain
	
	<Directory "/var/www/html/$namaDomain">
		Allowoverride All
	</Directory>


	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2ensite $namaDomain.conf

sudo systemctl restart apache2

printf '\n \n \n'
printf '============================ Albani Project ============================ \n'
echo Alhamdulillah, VHost berhasil dibuat
echo Dengan direktori kerja di /var/www/html/$namaDomain
echo Jangan lupa untuk menambahkan domain $namaDomain beserta ip pada file /etc/hosts
