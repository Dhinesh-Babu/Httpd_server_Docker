FROM httpd:2.4.41

# Update and install mod-security2 
RUN apt-get update
RUN apt-get install -y libapache2-mod-security2

WORKDIR /usr/local/apache2

# Create a error log
RUN touch error.log

COPY . .

# Overwriting our conf file to existing.
RUN mv httpd.conf ./conf/httpd.conf

RUN mv mod_security2.so ./modules/

RUN mv /etc/modsecurity/modsecurity.conf-recommended  modsecurity.conf

# Setting up Rules for OWASP
RUN cd owasp-modsecurity-crs && mv crs-setup.conf.example /etc/modsecurity/crs-setup.conf && mv rules/ /etc/modsecurity/

EXPOSE 80


ENTRYPOINT ["bash"]

#CMD ["-k start"]