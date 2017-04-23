FROM mysql:5.7

# add custom.cnf
ADD conf/custom.cnf /etc/mysql/conf.d/
# change configs permission 0644 to fit daemon only Windows environment.
RUN chmod 644 /etc/mysql/conf.d/custom.cnf
