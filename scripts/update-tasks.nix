{ pkgs, username, ... }:
pkgs.writeShellScriptBin "update-tasks" ''
cd /home/${username}/src/tasking/
cp -R /home/${username}/.config/task/task_data/* .

git add *
git commit -m 'script updating tasks'
git push
''
