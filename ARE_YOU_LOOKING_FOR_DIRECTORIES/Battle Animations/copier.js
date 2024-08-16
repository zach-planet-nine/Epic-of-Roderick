const fs = require('fs');
const path = require('path');

let characterRunes = {
  roderick: [],
  valkyrie: [],
  wizard: [],
  ranger: [],
  poet: []
};

const codePath = path.join(__dirname, '../../');
const runeAnimationsPath = path.join(__dirname, 'Rune\ Animations');
characterRunes.roderickPath = path.join(runeAnimationPath, 'Rodericks\ Runes');
characterRunes.valkyriePath = path.join(runeAnimationPath, 'Valkyries\ Runes');
characterRunes.wizardPath = path.join(runeAnimationPath, 'Wizards\ Runes');
characterRunes.rangerPath = path.join(runeAnimationPath, 'Rangers\ Runes');
characterRunes.poetPath = path.join(runeAnimationPath, 'Poets\ Runes');



const addRuneToCharacterRunes(file) => {
  const code = fs.readFileSync(file, {encoding: 'utf-8'});
  let characterToReturn;

  Object.keys(characterRunes).forEach(character => {
    if(code.indexOf(character) > -1) {
      characterRunes[character].push(file.split('AllEnemies')[0]);
      characterToReturn;
    }
  });

  return file;
}

const runes = fs.readdirSync('../../').filter(file => file.indexOf('AllEnemies') !== -1).map(file => addRuneToCharacterRunes(file)).map(file => file.split('AllEnemies')[0]);

Object.keys(characterRunes).forEach(character => {
  characterRunes[character].forEach(rune => {
    const runePath = path.join(characterRunes[`${character}Path`], rune);
    fs.mkdir(runePath);
    fs.copyFileSync(path.join(codePath, `${rune}SingleEnemy.h`), runePath);
    fs.copyFileSync(path.join(codePath, `${rune}AllEnemies.h`), runePath);
    fs.copyFileSync(path.join(codePath, `${rune}SingleCharacter.h`), runePath);
    fs.copyFileSync(path.join(codePath, `${rune}AllCharacters.h`), runePath);
    fs.copyFileSync(path.join(codePath, `${rune}SingleEnemy.m`), runePath);
    fs.copyFileSync(path.join(codePath, `${rune}AllEnemies.m`), runePath);
    fs.copyFileSync(path.join(codePath, `${rune}SingleCharacter.m`), runePath);
    fs.copyFileSync(path.join(codePath, `${rune}AllCharacters.m`), runePath);
  });
});
