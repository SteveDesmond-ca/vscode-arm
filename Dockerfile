FROM vtsv/arm:builder

ENV CC="/usr/bin/arm-linux-gnueabihf-gcc"
ENV CXX="/usr/bin/arm-linux-gnueabihf-g++ --sysroot=/rootfs -L/rootfs/usr/lib/arm-linux-gnueabihf -I/rootfs/usr/include/libsecret-1 -I/rootfs/usr/include/glib-2.0 -I/rootfs/usr/lib/arm-linux-gnueabihf/glib-2.0/include"
ENV PKG_CONFIG_PATH="/rootfs/usr/share/pkgconfig:/rootfs/usr/lib/arm-linux-gnueabihf/pkgconfig"

RUN mkdir /vscode
RUN mkdir /out

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install nodejs
RUN npm install -g yarn
RUN yarn add global \
  gulp \
  gulp-watch

ENV npm_config_arch=arm
ENV VSCODE_VERSION=1.30.0

RUN curl -L https://github.com/microsoft/vscode/archive/$VSCODE_VERSION.tar.gz > vscode.tar.gz
RUN tar --strip-components=1 -C /vscode -xf vscode.tar.gz

ENV dl_link=https://go.microsoft.com/fwlink/?LinkID=620884
RUN curl -L $dl_link > vscode-official.tar.gz
RUN tar --strip-components=1 -xf vscode-official.tar.gz VSCode-linux-x64/resources/app/resources/linux/code.png VSCode-linux-x64/resources/app/product.json

WORKDIR /vscode

RUN cp -rv ../resources/app/* .
RUN sed -i 's/.*darwinCredits.*//' product.json
RUN sed -i 's/.*electronRepository.*//' product.json

RUN yarn install --ignore-scripts
COPY vscode-sqlite.gyp node_modules/vscode-sqlite/binding.gyp
RUN yarn install
RUN yarn run gulp vscode-linux-arm-min
RUN yarn run gulp vscode-linux-arm-build-deb
ENTRYPOINT [ "sh", "-c", "cp -v /vscode/.build/linux/deb/armhf/deb/*.deb /out/vscode-$VSCODE_VERSION.deb" ]