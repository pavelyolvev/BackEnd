async function OnClicklogin() {
    const login = document.getElementById('user_name').value;
    //const login = 'ivanovv';
    const password = document.getElementById('user_pass').value;

    try {
        const response = await fetch('/login', {
            method: 'POST',  // Используем POST для передачи данных безопасно
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({login, password})  // Передаем данные в формате JSON
        });

        const data = await response.json();  // Получаем ответ от сервера в формате JSON

        if (data.success) {
            console.log('Успешная авторизация:', data.user);
        } else {
            console.log('Ошибка авторизации:', data.message);
        }
    } catch (error) {
        console.error('Ошибка сети:', error);
    }
}