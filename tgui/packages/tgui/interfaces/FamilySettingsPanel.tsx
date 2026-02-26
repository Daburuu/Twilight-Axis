import { useState } from 'react';
import { Window } from 'tgui/layouts';
import { useBackend } from 'tgui/backend';
import { Button, Box, Stack, Input, Dropdown, Icon } from 'tgui-core/components';

export const FamilySettingsPanel = () => {
  
  const [familyType, setFamilyType] = useState<'none' | 'member' | 'parent' | 'couple'>('none');

  const [racePreference, setRacePreference] = useState<'own' | 'any'>('any');
  const [genderPreference, setGenderPreference] = useState<'any' | 'same' | 'opposite'>('any');
  const [checkGenderStrict, setCheckGenderStrict] = useState(false);
  const [favoriteName, setFavoriteName] = useState('');
  const [familyName, setFamilyName] = useState(''); 
  const { act } = useBackend();

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
                if (selectedOption) setFamilyType(selectedOption.value as any);
              }}
              width="100%"
            />
            <Box
              style={{
                marginTop: '4px',
                fontSize: '12px',
                color: '#aaa',
                fontStyle: 'italic',
                paddingLeft: '4px',
              }}
            >
              {tooltips[familyType]}
            </Box>
          </Stack.Item>

          {familyType !== 'none' && (
            <>
              <Stack.Divider />
              <Stack.Item>
                <Box style={{ marginBottom: '8px', fontWeight: 'bold' }}>Дополнительные настройки</Box>
              </Stack.Item>

              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>Предпочтение по расе:</Box>
                <Dropdown
                  options={raceOptions.map(opt => opt.displayText)}
                  selected={getDisplayText(raceOptions, racePreference)}
                  onSelected={(selectedText) => {
                    const selectedOption = raceOptions.find(opt => opt.displayText === selectedText);
                    if (selectedOption) setRacePreference(selectedOption.value as any);
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
                    if (selectedOption) setGenderPreference(selectedOption.value as any);
                  }}
                  width="100%"
                />
              </Stack.Item>

              <Stack.Item>
                <Button
                  fluid
                  color={checkGenderStrict ? 'good' : 'default'}
                  onClick={() => setCheckGenderStrict(!checkGenderStrict)}
                  style={{ justifyContent: 'flex-start' }}
                >
                  <Icon
                    name={checkGenderStrict ? 'check-square-o' : 'square-o'}
                    style={{ marginRight: '8px' }}
                  />
                  Проверять соответствие пола и половых признаков
                </Button>
              </Stack.Item>

              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>Имя фаворита:</Box>
                <Input
                  placeholder="Укажите кого бы вы хотели видеть как свою пару. Оставьте пустым, если предпочтений нет"
                  value={favoriteName}
                  onChange={setFavoriteName}
                  fluid
                />
              </Stack.Item>

              {familyType === 'parent' && (
                <Stack.Item>
                  <Box style={{ marginBottom: '4px' }}>Название семьи:</Box>
                  <Input
                    placeholder="Введите название вашей семьи"
                    value={familyName}
                    onChange={setFamilyName}
                    fluid
                  />
                </Stack.Item>
              )}
            </>
          )}

          <Stack.Item mt={2}>
            <Button
              fluid
              color="good"
              onClick={() => {
                act('save', { familyType, racePreference, genderPreference, familyName, favoriteName, checkGenderStrict });
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
