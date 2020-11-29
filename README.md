# pdf-metadata-clear
shell script clean pdf metadata

## Dependence 
- qpdf
- exiftool

For MACOS users : use `brew install qpdf exiftool` to install

For Linux users : use `sudo apt-get qpdf exiftool` to install

## Usage  
* run `cd $PATH` where `$PATH` stands for where your clear.sh located
* run `sudo chmod +x ./clear.sh` to make the script executable 
* run `sudo ./clear.sh $FILE` where `$FILE` is a directory containing pdf files to clean or a specific pdf file.  
  If `$FILE` is left empty, the script while use `$pwd` as default.
