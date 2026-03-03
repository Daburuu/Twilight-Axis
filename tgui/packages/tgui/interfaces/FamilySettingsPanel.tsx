import { useState, useEffect } from 'react';
import { Window } from 'tgui/layouts';
import { useBackend } from 'tgui/backend';
import { Button, Box, Stack, Input, Dropdown } from 'tgui-core/components';

type FamilyType = 'none' | 'member' | 'parent' | 'couple';

type SpeciesMode =
  | 'ANY'
  | 'SAME_TYPE'
  | 'SAME_SUBTYPE'
  | 'SPECIFIC_TYPE'
  | 'SPECIFIC_SUBTYPE';

type GenderPref = 'any' | 'same' | 'opposite';

export const FamilySettingsPanel = () => {
  const { act, data } = useBackend();

  const settings = data?.familySettings;
  const speciesList: string[] = data?.availableSpecies || [];

  const isAdult = settings?.age === 'Adult';

  const [familyType, setFamilyType] = useState<FamilyType>('none');
  const [speciesMode, setSpeciesMode] = useState<SpeciesMode>('ANY');
  const [preferredSpeciesType, setPreferredSpeciesType] = useState<string | null>(null);
  const [preferredSpeciesSubtype, setPreferredSpeciesSubtype] = useState<string | null>(null);
  const [genderPreference, setGenderPreference] = useState<GenderPref>('any');
  const [favoriteName, setFavoriteName] = useState('');
  const [initialized, setInitialized] = useState(false);

  useEffect(() => {
    if (!settings || initialized) return;

    setFamilyType(settings.familyType ?? 'none');
    setSpeciesMode(settings.speciesPreferenceMode ?? 'ANY');
    setPreferredSpeciesType(settings.preferredSpeciesType ?? null);
    setPreferredSpeciesSubtype(settings.preferredSpeciesSubtype ?? null);
    setGenderPreference(settings.genderPreference ?? 'any');
    setFavoriteName(settings.favoriteName ?? '');

    setInitialized(true);
  }, [settings, initialized]);

  useEffect(() => {
    if (isAdult && familyType === 'parent') {
      setFamilyType('member');
    }
  }, [isAdult, familyType]);

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
  ].filter(opt => !(opt.value === 'parent' && isAdult));

  const speciesOptions = [
    { value: 'ANY', displayText: 'Любая' },
    { value: 'SAME_TYPE', displayText: 'Тот же тип' },
    { value: 'SAME_SUBTYPE', displayText: 'Тот же подтип' },
    { value: 'SPECIFIC_TYPE', displayText: 'Конкретная раса' },
    { value: 'SPECIFIC_SUBTYPE', displayText: 'Конкретная подраса' },
  ];

  const genderOptions = [
    { value: 'any', displayText: 'Любой' },
    { value: 'same', displayText: 'Тот же пол' },
    { value: 'opposite', displayText: 'Противоположный' },
  ];

  const getDisplayText = (
    options: { value: string; displayText: string }[],
    value: string
  ) => options.find(opt => opt.value === value)?.displayText || '';

  return (
    <Window title="Настройка семьи" width={600} height={600}>
      <Window.Content>
        <Stack vertical fill>

          <Stack.Item>
            <h2 style={{ textAlign: 'center' }}>
              Настройка семейных отношений
            </h2>
          </Stack.Item>

          {/* Тип семьи */}
          <Stack.Item>
            <Box style={{ marginBottom: '4px', fontWeight: 'bold' }}>
              Тип семьи:
            </Box>

            <Dropdown
              options={familyTypeOptions.map(opt => opt.displayText)}
              selected={getDisplayText(familyTypeOptions, familyType)}
              onSelected={(selectedText) => {
                const selectedOption = familyTypeOptions.find(
                  opt => opt.displayText === selectedText
                );
                if (selectedOption)
                  setFamilyType(selectedOption.value as FamilyType);
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

              {/* Предпочтение по расе */}
              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>
                  Предпочтение по расе:
                </Box>

                <Dropdown
                  options={speciesOptions.map(opt => opt.displayText)}
                  selected={getDisplayText(speciesOptions, speciesMode)}
                  onSelected={(selectedText) => {
                    const selectedOption = speciesOptions.find(
                      opt => opt.displayText === selectedText
                    );
                    if (selectedOption)
                      setSpeciesMode(selectedOption.value as SpeciesMode);
                  }}
                  width="100%"
                />
              </Stack.Item>

              {/* SPECIFIC_TYPE */}
              {speciesMode === 'SPECIFIC_TYPE' && (
                <Stack.Item>
                  <Box>Выберите расу:</Box>
                  <Dropdown
                    options={speciesList}
                    selected={preferredSpeciesType || ''}
                    onSelected={(value) => setPreferredSpeciesType(value)}
                    width="100%"
                  />
                </Stack.Item>
              )}

              {/* SPECIFIC_SUBTYPE */}
              {speciesMode === 'SPECIFIC_SUBTYPE' && (
                <>
                  <Stack.Item>
                    <Box>Выберите расу:</Box>
                    <Dropdown
                      options={speciesList}
                      selected={preferredSpeciesType || ''}
                      onSelected={(value) => setPreferredSpeciesType(value)}
                      width="100%"
                    />
                  </Stack.Item>

                  <Stack.Item>
                    <Box>Подраса:</Box>
                    <Input
                      value={preferredSpeciesSubtype || ''}
                      onChange={setPreferredSpeciesSubtype}
                      fluid
                    />
                  </Stack.Item>
                </>
              )}

              {/* Пол */}
              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>
                  Предпочтение по полу:
                </Box>

                <Dropdown
                  options={genderOptions.map(opt => opt.displayText)}
                  selected={getDisplayText(genderOptions, genderPreference)}
                  onSelected={(selectedText) => {
                    const selectedOption = genderOptions.find(
                      opt => opt.displayText === selectedText
                    );
                    if (selectedOption)
                      setGenderPreference(selectedOption.value as GenderPref);
                  }}
                  width="100%"
                />
              </Stack.Item>

              {/* Имя фаворита */}
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
                  speciesPreferenceMode: speciesMode,
                  preferredSpeciesType,
                  preferredSpeciesSubtype,
                  genderPreference,
                  favoriteName,
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
