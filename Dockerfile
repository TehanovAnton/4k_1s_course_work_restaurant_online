# syntax=docker/dockerfile:1
FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /rest-online
COPY . /rest-online
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN --mount=type=bind,target=/rest-online
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
EXPOSE 3000
EXPOSE 6379


# Configure the main process to run when running the image
CMD rails s -b 0.0.0.0 & sidekiq

# docker run -it --mount type=bind,src=./,target=/rest-online -dp 127.0.0.1:3000:3000 --network rest-online rest-online
# docker run -it --mount type=bind,src=./,target=/rest-online -dp 127.0.0.1:3000:3000 --network --network-alias rest-onlinei2EC#DRp,#a(i)_-api rest-online

# from docker hub
# docker run -it --mount type=bind,src=./,target=/rest-online -dp 127.0.0.1:3000:3000 --network rest-online tehanovanton/rest-online