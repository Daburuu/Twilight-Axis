import { useState, useEffect } from 'react';
import { Window } from 'tgui/layouts';
import { useBackend } from 'tgui/backend';
import { Button, Box, Stack, Input, Dropdown, Icon } from 'tgui-core/components';

type FamilyType = 'none' | 'member' | 'parent' | 'couple';
type RacePref = 'own' | 'any';
type GenderPref = 'any' | 'same' | 'opposite';

export const FamilySettingsPanel = () => {

  const { act, data } = useBackend();
  const settings = data?.familySettings;

  // === Mapping из DM чисел в строки ===
const mapFamily = (value: any): FamilyType => {
  switch (value) {
    case "None":
    case 0:
      return 'none';

    case "Partial":
    case 1:
      return 'member';

    case "Newlywed":
    case 2:
      return 'couple';

    case "Full":
    case 3:
      return 'parent';

    default:
      return 'none';
  }
};

  const mapGender = (value: any): GenderPref => {
    switch (value) {
      case 0: return 'any';       // ANY_GENDER
      case 1: return 'same';      // SAME_GENDER
      case 2: return 'opposite';  // DIFFERENT_GENDER
      default: return 'any';
    }
  };

  const mapRace = (value: any): RacePref => {
    return value === 1 ? 'own' : 'any';
  };

  const [familyType, setFamilyType] = useState<FamilyType>(mapFamily(settings.familyType));
  const [racePreference, setRacePreference] = useState<RacePref>(mapRace(settings.racePreference));
  const [genderPreference, setGenderPreference] = useState<GenderPref>(mapGender(settings.genderPreference));
  const [checkGenderStrict, setCheckGenderStrict] = useState(false);
  const [favoriteName, setFavoriteName] = useState(settings.favoriteName ?? '');
  const [familyName, setFamilyName] = useState('');

  // === Синхронизация при обновлении backend ===
  useEffect(() => {
  if (!settings) return;

  setFamilyType(mapFamily(settings.familyType));
  setRacePreference(mapRace(settings.racePreference));
  setGenderPreference(mapGender(settings.genderPreference));
  setFavoriteName(settings.favoriteName ?? '');
}, [settings]);

  const tooltips = {
    none: 'Ваш персонаж не будет частью чьей-либо семьи',
    member: 'Ваш персонаж возможно станет частью чьей-то семьи',
    parent: 'Ваш персонаж может стать основателем своей семьи, либо частью чьей-то семьи',
    couple: 'Ваш персонаж не будет частью чьей-то семьи, но у него будет возможность стать чьей-то парой',
  };

  const familyTypeOptions = [
    { value: 'none', displayText: 'Нет' },
    { value: 'member', displayText: 'Член семьи' },
    { value: 'parent', displayText: 'Родитель' },
    { value: 'couple', displayText: 'Пара' },
  ];

  const raceOptions = [
    { value: 'own', displayText: 'Только своя раса' },
    { value: 'any', displayText: 'Любая' },
  ];

  const genderOptions = [
    { value: 'any', displayText: 'Любой' },
    { value: 'same', displayText: 'Тот же пол' },
    { value: 'opposite', displayText: 'Противоположный' },
  ];

  const getDisplayText = (options: { value: string; displayText: string }[], value: string) => {
    return options.find(opt => opt.value === value)?.displayText || '';
  };

  return (
    <Window title="Настройка семьи" width={600} height={550}>
      <Window.Content>
        <Stack vertical fill>

          <Stack.Item>
            <h2 style={{ textAlign: 'center' }}>Настройка семейных отношений</h2>
          </Stack.Item>

          <Stack.Item>
            <Box style={{ marginBottom: '4px', fontWeight: 'bold' }}>Тип семьи:</Box>
            <Dropdown
              options={familyTypeOptions.map(opt => opt.displayText)}
              selected={getDisplayText(familyTypeOptions, familyType)}
              onSelected={(selectedText) => {
                const selectedOption = familyTypeOptions.find(opt => opt.displayText === selectedText);
                if (selectedOption) setFamilyType(selectedOption.value as FamilyType);
              }}
              width="100%"
            />
            <Box style={{
              marginTop: '4px',
              fontSize: '12px',
              color: '#aaa',
              fontStyle: 'italic',
              paddingLeft: '4px',
            }}>
              {tooltips[familyType]}
            </Box>
          </Stack.Item>

          {familyType !== 'none' && (
            <>
              <Stack.Divider />

              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>Предпочтение по расе:</Box>
                <Dropdown
                  options={raceOptions.map(opt => opt.displayText)}
                  selected={getDisplayText(raceOptions, racePreference)}
                  onSelected={(selectedText) => {
                    const selectedOption = raceOptions.find(opt => opt.displayText === selectedText);
                    if (selectedOption) setRacePreference(selectedOption.value as RacePref);
                  }}
                  width="100%"
                />
              </Stack.Item>

              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>Предпочтение по полу:</Box>
                <Dropdown
                  options={genderOptions.map(opt => opt.displayText)}
                  selected={getDisplayText(genderOptions, genderPreference)}
                  onSelected={(selectedText) => {
                    const selectedOption = genderOptions.find(opt => opt.displayText === selectedText);
                    if (selectedOption) setGenderPreference(selectedOption.value as GenderPref);
                  }}
                  width="100%"
                />
              </Stack.Item>

              <Stack.Item>
                <Input
                  placeholder="Имя фаворита"
                  value={favoriteName}
                  onChange={setFavoriteName}
                  fluid
                />
              </Stack.Item>
            </>
          )}

          <Stack.Item mt={2}>
            <Button
              fluid
              color="good"
              onClick={() => {
                act('save', {
                  familyType,
                  racePreference,
                  genderPreference,
                  familyName,
                  favoriteName,
                  checkGenderStrict,
                });
              }}
            >
              Сохранить настройки
            </Button>
          </Stack.Item>

        </Stack>
      </Window.Content>
    </Window>
  );
};
