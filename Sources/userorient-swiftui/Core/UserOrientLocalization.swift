import Foundation

/// Simple localization helper mirroring the Flutter L10n content.
enum UserOrientStrings {
    private static let content: [String: [String: String]] = [
        "az": [
            "title": "Təkliflər",
            "tip": "Tezliklə görmək istədiklərinizə səs verin.",
            "form_hint": "Təklifiniz nədir?",
            "submit_form": "Göndər",
            "sent_title": "Təklif göndərildi!",
            "sent_description": "Təklifinizi nəzərdən keçirəcəyik və əgər bizim yol xəritəmizə uyğun gələrsə, onu siyahıya əlavə edəcəyik. Gözləmədə qalın!",
            "go_back": "Geri qayıt",
            "add_feature": "Təklif Göndər",
            "roadmap": "Yol Xəritəsi",
            "implemented": "Tamamlanmış",
            "formEmpty": "Təklifinizi daxil edin",
            "comments": "Rəylər",
            "emptyTitle": "Hələ təklif yoxdur",
            "emptySubtitle": "Yeni təkliflər üçün sonra yoxlayın.",
            "noCommentsTitle": "Hələ rəy yoxdur",
            "noCommentsSubtitle": "Bu təklifə ilk rəy verən siz olun.",
            "addCommentPlaceholder": "Rəy əlavə edin...",
            "guestUser": "Qonaq",
            "errorTitle": "Xəta",
        ],
        "en": [
            "title": "Features",
            "tip": "Vote the features you want to see soon.",
            "form_hint": "Describe your idea...",
            "submit_form": "Submit",
            "sent_title": "Feature request sent!",
            "sent_description": "We will review your request and if it fits our roadmap, we will add it to our list of features to build. Stay tuned!",
            "go_back": "Go back",
            "add_feature": "Suggest Feature",
            "roadmap": "Roadmap",
            "implemented": "Implemented",
            "formEmpty": "Please enter your suggestion",
            "comments": "Comments",
            "emptyTitle": "No features yet",
            "emptySubtitle": "Check back later for new features.",
            "noCommentsTitle": "No comments yet",
            "noCommentsSubtitle": "Be the first to comment on this feature.",
            "addCommentPlaceholder": "Add a comment...",
            "guestUser": "Guest User",
            "errorTitle": "Error",
        ],
        "es": [
            "title": "Sugerencias",
            "tip": "Vota las funciones que deseas pronto.",
            "form_hint": "Describe tu idea...",
            "submit_form": "Enviar",
            "sent_title": "¡Solicitud de sugerencia enviada!",
            "sent_description": "Revisaremos tu solicitud y, si encaja en nuestra hoja de ruta, la añadiremos a nuestra lista de características por desarrollar. ¡Mantente atento!",
            "go_back": "Volver",
            "add_feature": "Agregar Sugerencia",
            "roadmap": "Ruta",
            "implemented": "Implementado",
            "formEmpty": "Ingresa tu sugerencia",
            "comments": "Comentarios",
            "emptyTitle": "Aún no hay sugerencias",
            "emptySubtitle": "Vuelve más tarde para ver nuevas sugerencias.",
            "noCommentsTitle": "Aún no hay comentarios",
            "noCommentsSubtitle": "Sé el primero en comentar esta sugerencia.",
            "addCommentPlaceholder": "Añade un comentario...",
            "guestUser": "Invitado",
            "errorTitle": "Error",
        ],
        "it": [
            "title": "Suggerimenti",
            "tip": "Vota le funzionalità che vuoi vedere presto.",
            "form_hint": "Descrivi la tua idea...",
            "submit_form": "Invia",
            "sent_title": "Richiesta di funzionalità inviata!",
            "sent_description": "Esamineremo la tua richiesta e, se si adatta alla nostra roadmap, la aggiungeremo alla nostra lista di funzionalità da sviluppare. Resta sintonizzato!",
            "go_back": "Torna indietro",
            "add_feature": "Aggiungi Funzionalità",
            "roadmap": "Rotta",
            "implemented": "Implementato",
            "formEmpty": "Inserisci il tuo suggerimento",
            "comments": "Commenti",
            "emptyTitle": "Nessuna funzionalità ancora",
            "emptySubtitle": "Torna più tardi per nuove funzionalità.",
            "noCommentsTitle": "Nessun commento ancora",
            "noCommentsSubtitle": "Sii il primo a commentare questa funzionalità.",
            "addCommentPlaceholder": "Aggiungi un commento...",
            "guestUser": "Ospite",
            "errorTitle": "Errore",
        ],
        "tr": [
            "title": "Öneriler",
            "tip": "Yakında görmek isteklerinizi oylayın.",
            "form_hint": "Fikrinizi tanımlayın...",
            "submit_form": "Gönder",
            "sent_title": "Öneri isteği gönderildi!",
            "sent_description": "Talebinizi inceleyeceğiz ve yol haritamıza uyuyorsa, geliştirilecek özellikler listemize ekleyeceğiz. Takipte kalın!",
            "go_back": "Geri dön",
            "add_feature": "Öneri Gönder",
            "roadmap": "Yol Haritası",
            "implemented": "Tamamlanmış",
            "formEmpty": "Önerinizi girin",
            "comments": "Yorumlar",
            "emptyTitle": "Henüz öneri yok",
            "emptySubtitle": "Yeni öneriler için daha sonra tekrar bakın.",
            "noCommentsTitle": "Henüz yorum yok",
            "noCommentsSubtitle": "Bu öneriye ilk yorumu siz yapın.",
            "addCommentPlaceholder": "Yorum ekleyin...",
            "guestUser": "Misafir",
            "errorTitle": "Hata",
        ],
        "ru": [
            "title": "Предложения",
            "tip": "Голосуйте за функции, которые хотите увидеть в ближайшее время.",
            "form_hint": "Опишите вашу идею...",
            "submit_form": "Отправить",
            "sent_title": "Запрос отправлен!",
            "sent_description": "Мы рассмотрим ваш запрос и, если он впишется в наш план развития, добавим его в список функций для реализации. Следите за обновлениями!",
            "go_back": "Назад",
            "add_feature": "Предложить идею",
            "roadmap": "План развития",
            "implemented": "Выполнено",
            "formEmpty": "Введите предложение",
            "comments": "Комментарии",
            "emptyTitle": "Пока нет предложений",
            "emptySubtitle": "Загляните позже — появятся новые.",
            "noCommentsTitle": "Пока нет комментариев",
            "noCommentsSubtitle": "Оставьте первый комментарий к этому предложению.",
            "addCommentPlaceholder": "Добавить комментарий...",
            "guestUser": "Гость",
            "errorTitle": "Ошибка",
        ],
        "ar": [
            "title": "الميزات",
            "tip": "صوت للميزات التي تريد رؤيتها قريباً.",
            "form_hint": "اصف فكرتك...",
            "submit_form": "إرسال",
            "sent_title": "تم إرسال طلب الميزة!",
            "sent_description": "سنراجع طلبك وإذا كان يتناسب مع خريطة طريقنا، سنضيفه إلى قائمة الميزات المراد تطويرها. ابق على اطلاع!",
            "go_back": "العودة",
            "add_feature": "اقتراح ميزة",
            "roadmap": "خريطة الطريق",
            "implemented": "مُنفذ",
            "formEmpty": "يرجى إدخال اقتراحك",
            "comments": "التعليقات",
            "emptyTitle": "لا توجد ميزات بعد",
            "emptySubtitle": "تحقق لاحقاً من الميزات الجديدة.",
            "noCommentsTitle": "لا توجد تعليقات بعد",
            "noCommentsSubtitle": "كن أول من يعلق على هذه الميزة.",
            "addCommentPlaceholder": "أضف تعليقاً...",
            "guestUser": "مستخدم زائر",
            "errorTitle": "خطأ",
        ],
        "uk": [
            "title": "Пропозиції",
            "tip": "Голосуйте за функції, які хочете побачити найближчим часом.",
            "form_hint": "Опишіть свою ідею...",
            "submit_form": "Надіслати",
            "sent_title": "Запит на функцію надіслано!",
            "sent_description": "Ми розглянемо ваш запит і, якщо він відповідає нашому плану розвитку, додамо його до списку функцій для реалізації. Стежте за оновленнями!",
            "go_back": "Назад",
            "add_feature": "Запропонувати функцію",
            "roadmap": "План розвитку",
            "implemented": "Реалізовано",
            "formEmpty": "Будь ласка, введіть пропозицію",
            "comments": "Коментарі",
            "emptyTitle": "Поки немає пропозицій",
            "emptySubtitle": "Перевірте пізніше — з’являться нові.",
            "noCommentsTitle": "Поки немає коментарів",
            "noCommentsSubtitle": "Залиште перший коментар до цієї пропозиції.",
            "addCommentPlaceholder": "Додати коментар...",
            "guestUser": "Гість",
            "errorTitle": "Помилка",
        ],
        "de": [
            "title": "Funktionen",
            "tip": "Stimmen Sie für die Funktionen ab, die Sie bald sehen möchten.",
            "form_hint": "Beschreiben Sie Ihre Idee...",
            "submit_form": "Absenden",
            "sent_title": "Funktionsanfrage gesendet!",
            "sent_description": "Wir prüfen Ihre Anfrage und fügen sie bei Übereinstimmung mit unserer Roadmap unserer Liste hinzu. Bleiben Sie dran!",
            "go_back": "Zurück",
            "add_feature": "Funktion vorschlagen",
            "roadmap": "Roadmap",
            "implemented": "Umgesetzt",
            "formEmpty": "Bitte geben Sie Ihren Vorschlag ein",
            "comments": "Kommentare",
            "emptyTitle": "Noch keine Funktionen",
            "emptySubtitle": "Schauen Sie später nach neuen Funktionen.",
            "noCommentsTitle": "Noch keine Kommentare",
            "noCommentsSubtitle": "Seien Sie der Erste, der diese Funktion kommentiert.",
            "addCommentPlaceholder": "Kommentar hinzufügen...",
            "guestUser": "Gast",
            "errorTitle": "Fehler",
        ],
        "fr": [
            "title": "Fonctionnalités",
            "tip": "Votez pour les fonctionnalités que vous souhaitez voir bientôt.",
            "form_hint": "Décrivez votre idée...",
            "submit_form": "Envoyer",
            "sent_title": "Demande de fonctionnalité envoyée !",
            "sent_description": "Nous examinerons votre demande et, si elle correspond à notre feuille de route, nous l'ajouterons à notre liste. Restez à l'écoute !",
            "go_back": "Retour",
            "add_feature": "Suggérer une fonctionnalité",
            "roadmap": "Feuille de route",
            "implemented": "Réalisé",
            "formEmpty": "Veuillez saisir votre suggestion",
            "comments": "Commentaires",
            "emptyTitle": "Pas encore de fonctionnalités",
            "emptySubtitle": "Revenez plus tard pour de nouvelles fonctionnalités.",
            "noCommentsTitle": "Pas encore de commentaires",
            "noCommentsSubtitle": "Soyez le premier à commenter cette fonctionnalité.",
            "addCommentPlaceholder": "Ajouter un commentaire...",
            "guestUser": "Invité",
            "errorTitle": "Erreur",
        ],
        "hi": [
            "title": "फ़ीचर्स",
            "tip": "जल्द देखना चाहने वाले फ़ीचर्स के लिए वोट दें।",
            "form_hint": "अपना विचार बताएं...",
            "submit_form": "जमा करें",
            "sent_title": "फ़ीचर अनुरोध भेजा गया!",
            "sent_description": "हम आपके अनुरोध की समीक्षा करेंगे और अगर वह हमारे रोडमैप से मेल खाता है तो उसे सूची में जोड़ देंगे। बने रहें!",
            "go_back": "वापस जाएं",
            "add_feature": "फ़ीचर सुझाएं",
            "roadmap": "रोडमैप",
            "implemented": "लागू",
            "formEmpty": "कृपया अपना सुझाव दर्ज करें",
            "comments": "टिप्पणियाँ",
            "emptyTitle": "अभी तक कोई फ़ीचर नहीं",
            "emptySubtitle": "नए फ़ीचर्स के लिए बाद में देखें।",
            "noCommentsTitle": "अभी तक कोई टिप्पणी नहीं",
            "noCommentsSubtitle": "इस फ़ीचर पर पहली टिप्पणी करें।",
            "addCommentPlaceholder": "टिप्पणी जोड़ें...",
            "guestUser": "अतिथि",
            "errorTitle": "त्रुटि",
        ],
        "id": [
            "title": "Fitur",
            "tip": "Voting fitur yang ingin Anda lihat segera.",
            "form_hint": "Jelaskan ide Anda...",
            "submit_form": "Kirim",
            "sent_title": "Permintaan fitur terkirim!",
            "sent_description": "Kami akan meninjau permintaan Anda dan jika sesuai dengan peta jalan kami, kami akan menambahkannya ke daftar. Nantikan!",
            "go_back": "Kembali",
            "add_feature": "Usulkan Fitur",
            "roadmap": "Peta Jalan",
            "implemented": "Diimplementasikan",
            "formEmpty": "Silakan masukkan saran Anda",
            "comments": "Komentar",
            "emptyTitle": "Belum ada fitur",
            "emptySubtitle": "Periksa lagi nanti untuk fitur baru.",
            "noCommentsTitle": "Belum ada komentar",
            "noCommentsSubtitle": "Jadilah yang pertama mengomentari fitur ini.",
            "addCommentPlaceholder": "Tambah komentar...",
            "guestUser": "Tamu",
            "errorTitle": "Kesalahan",
        ],
        "ja": [
            "title": "機能",
            "tip": "早く見たい機能に投票してください。",
            "form_hint": "アイデアを説明してください...",
            "submit_form": "送信",
            "sent_title": "機能リクエストを送信しました！",
            "sent_description": "リクエストを確認し、ロードマップに合えばリストに追加します。お楽しみに！",
            "go_back": "戻る",
            "add_feature": "機能を提案",
            "roadmap": "ロードマップ",
            "implemented": "実装済み",
            "formEmpty": "提案を入力してください",
            "comments": "コメント",
            "emptyTitle": "まだ機能はありません",
            "emptySubtitle": "新しい機能は後でご確認ください。",
            "noCommentsTitle": "まだコメントはありません",
            "noCommentsSubtitle": "この機能に最初にコメントしてください。",
            "addCommentPlaceholder": "コメントを追加...",
            "guestUser": "ゲスト",
            "errorTitle": "エラー",
        ],
        "ko": [
            "title": "기능",
            "tip": "빨리 보고 싶은 기능에 투표하세요.",
            "form_hint": "아이디어를 설명해 주세요...",
            "submit_form": "제출",
            "sent_title": "기능 요청이 전송되었습니다!",
            "sent_description": "요청을 검토하고 로드맵에 맞으면 목록에 추가하겠습니다. 기대해 주세요!",
            "go_back": "돌아가기",
            "add_feature": "기능 제안",
            "roadmap": "로드맵",
            "implemented": "구현됨",
            "formEmpty": "제안을 입력해 주세요",
            "comments": "댓글",
            "emptyTitle": "아직 기능이 없습니다",
            "emptySubtitle": "나중에 새 기능을 확인해 주세요.",
            "noCommentsTitle": "아직 댓글이 없습니다",
            "noCommentsSubtitle": "이 기능에 첫 댓글을 남겨 보세요.",
            "addCommentPlaceholder": "댓글 추가...",
            "guestUser": "게스트",
            "errorTitle": "오류",
        ],
        "nl": [
            "title": "Functies",
            "tip": "Stem op de functies die u snel wilt zien.",
            "form_hint": "Beschrijf uw idee...",
            "submit_form": "Verzenden",
            "sent_title": "Functieverzoek verzonden!",
            "sent_description": "We beoordelen uw verzoek en voegen het toe aan onze lijst als het past bij onze roadmap. Blijf op de hoogte!",
            "go_back": "Terug",
            "add_feature": "Functie voorstellen",
            "roadmap": "Roadmap",
            "implemented": "Geïmplementeerd",
            "formEmpty": "Voer uw suggestie in",
            "comments": "Reacties",
            "emptyTitle": "Nog geen functies",
            "emptySubtitle": "Kom later terug voor nieuwe functies.",
            "noCommentsTitle": "Nog geen reacties",
            "noCommentsSubtitle": "Wees de eerste die op deze functie reageert.",
            "addCommentPlaceholder": "Reactie toevoegen...",
            "guestUser": "Gast",
            "errorTitle": "Fout",
        ],
        "pl": [
            "title": "Funkcje",
            "tip": "Głosuj na funkcje, które chcesz zobaczyć wkrótce.",
            "form_hint": "Opisz swój pomysł...",
            "submit_form": "Wyślij",
            "sent_title": "Prośba o funkcję wysłana!",
            "sent_description": "Zweryfikujemy Twoją prośbę i jeśli pasuje do naszej mapy drogowej, dodamy ją do listy. Śledź nas!",
            "go_back": "Wstecz",
            "add_feature": "Zaproponuj funkcję",
            "roadmap": "Mapa drogowa",
            "implemented": "Zaimplementowano",
            "formEmpty": "Wprowadź swoją sugestię",
            "comments": "Komentarze",
            "emptyTitle": "Brak funkcji",
            "emptySubtitle": "Sprawdź później nowe funkcje.",
            "noCommentsTitle": "Brak komentarzy",
            "noCommentsSubtitle": "Bądź pierwszy, który skomentuje tę funkcję.",
            "addCommentPlaceholder": "Dodaj komentarz...",
            "guestUser": "Gość",
            "errorTitle": "Błąd",
        ],
        "pt-br": [
            "title": "Recursos",
            "tip": "Vote nos recursos que você quer ver em breve.",
            "form_hint": "Descreva sua ideia...",
            "submit_form": "Enviar",
            "sent_title": "Solicitação de recurso enviada!",
            "sent_description": "Analisaremos sua solicitação e, se estiver alinhada ao nosso roadmap, a adicionaremos à lista. Fique de olho!",
            "go_back": "Voltar",
            "add_feature": "Sugerir recurso",
            "roadmap": "Roadmap",
            "implemented": "Implementado",
            "formEmpty": "Digite sua sugestão",
            "comments": "Comentários",
            "emptyTitle": "Ainda não há recursos",
            "emptySubtitle": "Volte mais tarde para novos recursos.",
            "noCommentsTitle": "Ainda não há comentários",
            "noCommentsSubtitle": "Seja o primeiro a comentar este recurso.",
            "addCommentPlaceholder": "Adicionar comentário...",
            "guestUser": "Visitante",
            "errorTitle": "Erro",
        ],
        "pt-pt": [
            "title": "Funcionalidades",
            "tip": "Vote nas funcionalidades que quer ver em breve.",
            "form_hint": "Descreva a sua ideia...",
            "submit_form": "Enviar",
            "sent_title": "Pedido de funcionalidade enviado!",
            "sent_description": "Analisaremos o seu pedido e, se estiver alinhado com o nosso roadmap, adicioná-lo-emos à lista. Fique atento!",
            "go_back": "Voltar",
            "add_feature": "Sugerir funcionalidade",
            "roadmap": "Roadmap",
            "implemented": "Implementado",
            "formEmpty": "Introduza a sua sugestão",
            "comments": "Comentários",
            "emptyTitle": "Ainda não há funcionalidades",
            "emptySubtitle": "Volte mais tarde para novas funcionalidades.",
            "noCommentsTitle": "Ainda não há comentários",
            "noCommentsSubtitle": "Seja o primeiro a comentar esta funcionalidade.",
            "addCommentPlaceholder": "Adicionar comentário...",
            "guestUser": "Visitante",
            "errorTitle": "Erro",
        ],
        "th": [
            "title": "ฟีเจอร์",
            "tip": "โหวตฟีเจอร์ที่คุณอยากเห็นเร็วๆ นี้",
            "form_hint": "อธิบายไอเดียของคุณ...",
            "submit_form": "ส่ง",
            "sent_title": "ส่งคำขอฟีเจอร์แล้ว!",
            "sent_description": "เราจะตรวจสอบคำขอของคุณ และถ้าสอดคล้องกับ roadmap ของเรา จะเพิ่มเข้าในรายการ ติดตามได้เลย!",
            "go_back": "กลับ",
            "add_feature": "เสนอฟีเจอร์",
            "roadmap": "แผนงาน",
            "implemented": "ดำเนินการแล้ว",
            "formEmpty": "กรุณาใส่ข้อเสนอของคุณ",
            "comments": "ความคิดเห็น",
            "emptyTitle": "ยังไม่มีฟีเจอร์",
            "emptySubtitle": "กลับมาดูฟีเจอร์ใหม่ในภายหลัง",
            "noCommentsTitle": "ยังไม่มีความคิดเห็น",
            "noCommentsSubtitle": "เป็นคนแรกที่แสดงความคิดเห็นในฟีเจอร์นี้",
            "addCommentPlaceholder": "เพิ่มความคิดเห็น...",
            "guestUser": "ผู้ใช้ทั่วไป",
            "errorTitle": "ข้อผิดพลาด",
        ],
        "vi": [
            "title": "Tính năng",
            "tip": "Bình chọn các tính năng bạn muốn thấy sớm.",
            "form_hint": "Mô tả ý tưởng của bạn...",
            "submit_form": "Gửi",
            "sent_title": "Đã gửi yêu cầu tính năng!",
            "sent_description": "Chúng tôi sẽ xem xét yêu cầu và nếu phù hợp với lộ trình sẽ thêm vào danh sách. Hãy theo dõi!",
            "go_back": "Quay lại",
            "add_feature": "Đề xuất tính năng",
            "roadmap": "Lộ trình",
            "implemented": "Đã triển khai",
            "formEmpty": "Vui lòng nhập đề xuất của bạn",
            "comments": "Bình luận",
            "emptyTitle": "Chưa có tính năng nào",
            "emptySubtitle": "Quay lại sau để xem tính năng mới.",
            "noCommentsTitle": "Chưa có bình luận",
            "noCommentsSubtitle": "Hãy là người đầu tiên bình luận tính năng này.",
            "addCommentPlaceholder": "Thêm bình luận...",
            "guestUser": "Khách",
            "errorTitle": "Lỗi",
        ],
        "zh-hans": [
            "title": "功能",
            "tip": "为您希望尽快看到的功能投票。",
            "form_hint": "描述您的想法...",
            "submit_form": "提交",
            "sent_title": "功能请求已发送！",
            "sent_description": "我们会审核您的请求，若符合我们的路线图将加入待开发列表。敬请关注！",
            "go_back": "返回",
            "add_feature": "建议功能",
            "roadmap": "路线图",
            "implemented": "已实现",
            "formEmpty": "请输入您的建议",
            "comments": "评论",
            "emptyTitle": "暂无功能",
            "emptySubtitle": "请稍后再查看新功能。",
            "noCommentsTitle": "暂无评论",
            "noCommentsSubtitle": "成为第一个评论此功能的人。",
            "addCommentPlaceholder": "添加评论...",
            "guestUser": "访客",
            "errorTitle": "错误",
        ],
    ]

    private static func bundle(for languageCode: String?) -> [String: String] {
        let normalized = languageCode?.lowercased() ?? "en"
        if let localized = content[normalized] {
            return localized
        }
        return content["en"] ?? [:]
    }

    static func title(languageCode: String?) -> String {
        bundle(for: languageCode)["title"] ?? "Features"
    }

    static func tip(languageCode: String?) -> String {
        bundle(for: languageCode)["tip"] ?? ""
    }

    static func formHint(languageCode: String?) -> String {
        bundle(for: languageCode)["form_hint"] ?? ""
    }

    static func submitForm(languageCode: String?) -> String {
        bundle(for: languageCode)["submit_form"] ?? "Submit"
    }

    static func sentTitle(languageCode: String?) -> String {
        bundle(for: languageCode)["sent_title"] ?? ""
    }

    static func sentDescription(languageCode: String?) -> String {
        bundle(for: languageCode)["sent_description"] ?? ""
    }

    static func goBack(languageCode: String?) -> String {
        bundle(for: languageCode)["go_back"] ?? "Go back"
    }

    static func addFeature(languageCode: String?) -> String {
        bundle(for: languageCode)["add_feature"] ?? "Suggest Feature"
    }

    static func roadmap(languageCode: String?) -> String {
        bundle(for: languageCode)["roadmap"] ?? "Roadmap"
    }

    static func implemented(languageCode: String?) -> String {
        bundle(for: languageCode)["implemented"] ?? "Implemented"
    }

    static func formEmpty(languageCode: String?) -> String {
        bundle(for: languageCode)["formEmpty"] ?? ""
    }

    static func comments(languageCode: String?) -> String {
        bundle(for: languageCode)["comments"] ?? "Comments"
    }

    // Additional helper strings for SwiftUI UI

    static func emptyTitle(languageCode: String?) -> String {
        bundle(for: languageCode)["emptyTitle"] ?? "No features yet"
    }

    static func emptySubtitle(languageCode: String?) -> String {
        bundle(for: languageCode)["emptySubtitle"] ?? "Check back later for new features."
    }

    static func noCommentsTitle(languageCode: String?) -> String {
        bundle(for: languageCode)["noCommentsTitle"] ?? "No comments yet"
    }

    static func noCommentsSubtitle(languageCode: String?) -> String {
        bundle(for: languageCode)["noCommentsSubtitle"] ?? "Be the first to comment on this feature."
    }

    static func addCommentPlaceholder(languageCode: String?) -> String {
        bundle(for: languageCode)["addCommentPlaceholder"] ?? "Add a comment..."
    }

    static func guestUser(languageCode: String?) -> String {
        bundle(for: languageCode)["guestUser"] ?? "Guest User"
    }

    static func errorTitle(languageCode: String?) -> String {
        bundle(for: languageCode)["errorTitle"] ?? "Error"
    }
}

enum UserOrientDateFormatter {
    static func relativeString(for date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

