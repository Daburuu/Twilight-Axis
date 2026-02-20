import { useState } from 'react';
import { Window } from 'tgui/layouts';
import { Button, Box, Stack, Input, Icon } from 'tgui-core/components';

export const FamilySettingsPanel = (props) => {
  // Состояние выбора типа семьи
  const [familyType, setFamilyType] = useState<'none' | 'member' | 'parent' | 'couple'>('none');

  // Состояния дополнительных полей (появляются, если выбрано не "Нет")
  const [racePreference, setRacePreference] = useState<'own' | 'any'>('any');
  const [genderPreference, setGenderPreference] = useState<'any' | 'same' | 'opposite'>('any');
  const [checkGenderStrict, setCheckGenderStrict] = useState(false);
  const [favoriteName, setFavoriteName] = useState('');

  // Подсказки для каждого типа
  const tooltips = {
    none: 'Ваш персонаж не будет частью чьей-либо семьи',
    member: 'Ваш персонаж возможно станет частью чьей-то семьи',
    parent: 'Ваш персонаж может стать основателем своей семьи, либо частью чьей-то семьи',
    couple: 'Ваш персонаж не будет частью чьей-то семьи, но у него будет возможность стать чьей-то парой',
  };

  // Обработчик выбора типа
  const handleTypeSelect = (type: typeof familyType) => {
    setFamilyType(type);
  };

  return (
    <Window title="Настройка семьи" width={600} height={500}>
      <Window.Content>
        <Stack vertical fill>
          {/* Заголовок */}
          <Stack.Item>
            <h2 style={{ textAlign: 'center' }}>Настройка семейных отношений</h2>
          </Stack.Item>

          {/* Выбор типа семьи */}
          <Stack.Item>
            <Box style={{ marginBottom: '8px', fontWeight: 'bold' }}>Тип семьи:</Box>
            <Stack>
              {(['none', 'member', 'parent', 'couple'] as const).map((type) => (
                <Stack.Item key={type} grow>
                  <Button
                    fluid
                    selected={familyType === type}
                    onClick={() => handleTypeSelect(type)}
                    style={{ textTransform: 'capitalize' }}
                  >
                    {type === 'none' ? 'Нет' :
                     type === 'member' ? 'Член семьи' :
                     type === 'parent' ? 'Родитель' : 'Пара'}
                  </Button>
                </Stack.Item>
              ))}
            </Stack>
            {/* Подсказка под выбранным типом */}
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

          {/* Дополнительные поля (если выбрано не "Нет") */}
          {familyType !== 'none' && (
            <>
              <Stack.Divider />
              <Stack.Item>
                <Box style={{ marginBottom: '8px', fontWeight: 'bold' }}>Дополнительные настройки</Box>
              </Stack.Item>

              {/* Предпочтение по расе */}
              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>Предпочтение по расе:</Box>
                <Stack>
                  <Stack.Item grow>
                    <Button
                      fluid
                      selected={racePreference === 'own'}
                      onClick={() => setRacePreference('own')}
                    >
                      Только своя раса
                    </Button>
                  </Stack.Item>
                  <Stack.Item grow>
                    <Button
                      fluid
                      selected={racePreference === 'any'}
                      onClick={() => setRacePreference('any')}
                    >
                      Любая
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>

              {/* Предпочтение по полу */}
              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>Предпочтение по полу:</Box>
                <Stack>
                  <Stack.Item grow>
                    <Button
                      fluid
                      selected={genderPreference === 'any'}
                      onClick={() => setGenderPreference('any')}
                    >
                      Любой
                    </Button>
                  </Stack.Item>
                  <Stack.Item grow>
                    <Button
                      fluid
                      selected={genderPreference === 'same'}
                      onClick={() => setGenderPreference('same')}
                    >
                      Тот же пол
                    </Button>
                  </Stack.Item>
                  <Stack.Item grow>
                    <Button
                      fluid
                      selected={genderPreference === 'opposite'}
                      onClick={() => setGenderPreference('opposite')}
                    >
                      Противоположный
                    </Button>
                  </Stack.Item>
                </Stack>
              </Stack.Item>

              {/* Чекбокс "Проверять соответствие пола и половых признаков" */}
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

              {/* Имя фаворита */}
              <Stack.Item>
                <Box style={{ marginBottom: '4px' }}>Имя фаворита:</Box>
                <Input
                  placeholder="Укажите кого бы вы хотели видеть как свою пару. Оставьте пустым, если предпочтений нет"
                  value={favoriteName}
                  onChange={setFavoriteName}
                  fluid
                />
              </Stack.Item>
            </>
          )}

          {/* Кнопка сохранения (пример) */}
          <Stack.Item mt={2}>
            <Button
              fluid
              color="good"
              onClick={() => {
                // Здесь будет act() или другой обработчик
                alert('Настройки сохранены (демо)');
              }}
            >
              Сохранить настройки
            </Button>
          </Stack.Item>

          {/* Небольшая пасхалка в стиле референса (опционально) */}
          <Stack.Item mt={1}>
            <Box
              style={{
                fontSize: '10px',
                color: '#666',
                textAlign: 'center',
                userSelect: 'none',
              }}
              onClick={() => alert('🐱 Семья — это важно!')}
            >
              Сделано с любовью
            </Box>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
