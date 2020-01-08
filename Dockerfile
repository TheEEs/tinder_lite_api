FROM trandat/tinderlite_api
ADD /tinderlite /home/
EXPOSE 3000
WORKDIR /home/tinderlite
RUN RAILS_ENV=production rake db:reset
CMD rails s -b 0.0.0.0 -e production
