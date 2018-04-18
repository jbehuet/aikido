#!/bin/bash

# Reset
RCol='\033[0m'       # Text Reset

# Regular Colors
Bla='\033[0;30m';
Red='\033[0;31m';
Gre='\033[0;32m';
Yel='\033[0;33m';
Blu='\033[0;34m';
Pur='\033[0;35m';
Cya='\033[0;36m';
Whi='\033[0;37m';

echo -e "${Yel}------------"
echo -e " DEPLOYING"
echo -e "------------ ${RCol}"

echo -e "* Prepare : ${Gre}(1/5)${RCol}"
# Build the content of the website into dist-build folder
rm -rf dist

# Cloning master branch (GH PAGES) into dist folder
git clone -b master https://github.com/jbehuet/aikido.git dist/
cd dist
ls | grep -v -E ".git" | xargs rm -rf

cd ..
# Build app
echo -e "* Build : ${Gre}(2/5)${RCol}"
npm run build

# Add new resources
cd dist
git add .

echo -e "* Commit : ${Gre}(3/5)${RCol}"
git commit -m "Auto-deploy - dist"


echo -e "* Push to ${Yel}${ENV}${RCol}: ${Gre}(4/5)${RCol}"
# Pushing to master branch, which is sync-ed with www.bdx.io ... only if there are more than 10 files in current directory
git push origin master
cd ..

# Clean generated folders
echo -e "* Clean : ${Gre}(5/5)${RCol}"
rm -rf dist

echo
echo '----------------------------------------------------------'
echo -e "Deployed to : ${Cya}https://kihon.fr${RCol}"
echo '----------------------------------------------------------'
