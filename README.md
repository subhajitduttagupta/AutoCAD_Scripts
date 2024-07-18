
# AutoCAD_Scripts

AutoCAD scripts for Electrical Engineers 

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
- Automated Ferrule Number export to Excel with X Y Co-Ordinates
- Automated continuous Ferrule Number generator in the drawing
- Add Prefix and Suffix in any text or number in just one click
- Delete any texts with specified Prefix just by selecting an area, (No need to search manually)


## Author

- [@subhajitduttagupta](https://github.com/subhajitduttagupta)


## Deployment

To deploy these scripts, Open a drawing in AutoCAD and type

```bash
  APPLOAD
```
Then browse to the file location and click on "load", Then "Always Load", Then write the respective commands given below.

## COMMANDS

### export_ferrule_coordinates_Prefix
Exports Ferrule Numbers with X, Y Co-ordinates, Text size and Text Orientation as a CSV file from AutoCAD Drawing in your Documents folder.
```bash
  EXPORTFERRULECOORDINATES
```
- After the command you need to provide a prefix which will helps to identify the Ferrule Numbers. 
For example there are 100s of Ferrule Numbers like Q101, Q102, ... so on, in this example every Ferrule Number starts with Q so the Prefix would be Q. If your Ferrule Number has multiple prefixes like R, S, T then you need to run Add_Prefix_And_Suffix script for give them a generalised prefix.
- After that press Enter and then a CSV file named ferrule_coordinates.csv will be created in your "Documents" folder.
### Increment_Text_Or_Ferrule_Prefix_Suffix
Increment numaric charecters by 1 of multiple text automatically and chronologically even if you have other charecters in your texts.
```bash
  INCREMENTTEXTCOMMAND
```
- After the command you need to give a prefix or suffix or both for identify the numaric charecters.
For example suppose you have a text Q101-T. then the numaric charecter will be 101 and Prefix will be Q and suffix will be -T.
- After giving prefix and suffix you need to start selecting the texts. The first text you select would be the one from where you need to start incremental counting.
For example,

You have text like, Q101-T, Q101-T, Q100-T, Q10-T, Q107-T, Q155-T, ...

- First give Prefix Q and Suffix -T
- Then you need to select the first Q101-T then all the texts and then press Enter.
- Your OUTPUT will be like this, Q101-T, Q102-T, Q103-T, Q104-T, Q105-T, Q106-T, ...
### Add_Prefix_And_Suffix
Add Prefix and Suffix in multiple texts automatically
```bash
  ADDPREFIXANDSUFFIXTOTEXTCOMMAND
```
- After the command you need to give a prefix or suffix or both
- After that you need to select the texts where you want to add those prefix and suffix After that press Enter, and all the selected texts will be modified
### Delete_Text_With_Prefix
Delete texts having your defined prefix in a area you select in just a click
```bash
  DELTEXTINAREA
```
- After the command enter the common prefix for the texts you want to delete. 
For example you want to delete all the texts which starts with Q like, Q101-T, Q101-T, Q100-T, Q10-T, Q107-T, Q155-T, ...
- After that select an area in the drawing from where you want to delete the texts and press Enter, all the texts in that area having your given prefix will be deleted.
