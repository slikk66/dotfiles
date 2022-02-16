# include following in .bashrc / .bash_profile / .zshrc
# usage
# $ mkvenv myvirtualenv # creates venv under ~/.venv/
# $ venv myvirtualenv   # activates venv
# $ deactivate          # deactivates venv
# $ rmvenv myvirtualenv # removes venv
# $ lsvenv              # print all created venv's

export VENV_HOME="$HOME/.venv"
[[ -d $VENV_HOME ]] || mkdir $VENV_HOME

venv() {
  source "$VENV_HOME/$1/bin/activate"
}

mkvenv() {
  python3 -m venv $VENV_HOME/$1
}

rmvenv() {
  if [[ -z $VENV_HOME || -z $1 ]]
    then
      echo "Please pass the name of the venv"
  else
      rm -r $VENV_HOME/$1
  fi
}

lsvenv() {
    ls $VENV_HOME | egrep -v "bin|include|lib|lib64|pyvenv.cfg"
}
