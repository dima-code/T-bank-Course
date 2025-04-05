/*
 
Вам необходимо разработать приложение, в котором отображается карточка товара из приложения Т-банка с небольшими изменениями (см. вложение). При нажатии на кнопку в нижней части экрана товар меняется. В приложении должно быть доступно не менее 5 разных товаров, после показа последнего переходим на карточку первого показанного товара. Зачеркнутый лейбл в карточке опционален.
При разработке учтите критерии ниже:
Верстка кодом без использования Storyboard;
Необходимо задать констрейнты так, чтобы интерфейс был адаптирован для разных моделей iPhone. Условно, выглядел хорошо и на Phone 16 Pro Max, и на iPhone 12 mini;
Шрифт и размер лейблов желательно подобрать похожий, но точное соответствие не требуется.

 
Код для метода SceneDelegate, чтобы верстать в коде:
 
 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = YourNameViewController()
        self.window?.makeKeyAndVisible()
    }
 
*/
