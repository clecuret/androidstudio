FROM env/dev
MAINTAINER clecuret <clecuret@gmail.com>
ENV ANDROID_STUDIO_URL https://dl.google.com/dl/android/studio/ide-zips/2.1.0.9/android-studio-ide-143.2790544-linux.zip
RUN apt-get update && apt-get install -y unzip && curl "${ANDROID_STUDIO_URL}" > /tmp/studio.zip && unzip -d /opt /tmp/studio.zip && rm /tmp/studio.zip
RUN apt-get install -y lib32stdc++6  lib32z1 lib32ncurses5-dev
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["androidstudio"]
