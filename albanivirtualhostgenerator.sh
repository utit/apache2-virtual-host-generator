#!bash

##mulai
echo Masukan nama domain yang akan dibuat contoh: albani.id !
read namaDomain
##membuat direktori root proyek
sudo mkdir  /var/www/html/$namaDomain
sudo chown -R $USER:$USER /var/www/html/$namaDomain
sudo chmod -R 755 /var/www/html/$namaDomain
echo '<center style="margin-top:50px">Alhamdulillah, kamu berhasil membuat virtual host/domain <b>'.$namaDomain.'</b></center>' >> /var/www/html/$namaDomain/index.html

sudo tee -a /etc/apache2/sites-available/$namaDomain.conf << 'EOF'
<VirtualHost *:80>
	
	ServerAdmin admin@localhost
	ServerName $namaDomain.conf
	ServerAlias www.$namaDomain.conf
	DocumentRoot /var/www/html/$namaDomain.conf
	
	<Directory "/var/www/html/$namaDomain.conf">
		Allowoverride All
	</Directory>


	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2ensite $namaDomain.conf

sudo systemctl restart apache2


