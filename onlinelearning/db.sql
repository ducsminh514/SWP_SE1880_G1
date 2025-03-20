USE [master]
GO
CREATE DATABASE [SWP52]
USE [SWP52]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
    [CartID] [int] IDENTITY(1,1) NOT NULL,
    [CustomerID] [int] NULL,
    [CreatedDate] [datetime] NULL,
    [Status] [bit] NULL,
    CONSTRAINT [PK__Carts__51BCD797445B00A4] PRIMARY KEY CLUSTERED
(
[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[CategoryBlog]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[CategoryBlog](
    [CategoryBlogID] [int] NOT NULL,
    [CategoryBlogName] [nvarchar](255) NULL,
    PRIMARY KEY CLUSTERED
(
[CategoryBlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[CommentPost]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[CommentPost](
    [CommentPostID] [int] IDENTITY(1,1) NOT NULL,
    [ParentID] [int] NULL,
    [PostID] [int] NOT NULL,
    [UserID] [int] NOT NULL,
    [Content] [nvarchar](max) NOT NULL,
    [CreateDate] [datetime] NULL,
    PRIMARY KEY CLUSTERED
(
[CommentPostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Course_Type]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Course_Type](
    [course_typeId] [int] NOT NULL,
    [course_typeName] [nvarchar](100) NULL,
    PRIMARY KEY CLUSTERED
(
[course_typeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Courses]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Courses](
    [CourseID] [int] IDENTITY(1,1) NOT NULL,
    [course_typeId] [int] NULL,
    [CourseName] [nvarchar](100) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [CreatedDate] [datetime] NULL,
    [Price] [float] NULL,
    [title] [nvarchar](255) NULL,
    [thumbnail] [nvarchar](255) NULL,
    [ExpertID] [int] NULL,
    [status] [bit] NULL,
    CONSTRAINT [PK__Courses__C92D7187A4FDA07D] PRIMARY KEY CLUSTERED
(
[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Customers](
    [CustomerID] [int] IDENTITY(1,1) NOT NULL,
    [SocialRole] [nvarchar](50) NULL,
    [LevelOfEnglish] [nvarchar](50) NULL,
    [UserID] [int] NULL,
    CONSTRAINT [PK__Customer__A4AE64B8783DDB6B] PRIMARY KEY CLUSTERED
(
[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Enrollments]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Enrollments](
    [EnrollmentID] [int] IDENTITY(1,1) NOT NULL,
    [EnrollDate] [datetime] NULL,
    [Status] [nvarchar](50) NULL,
    [Pay_Code] [nvarchar](100) NULL,
    [Process_Percentage] [nvarchar](50) NULL,
    [CustomerID] [int] NULL,
    [CourseID] [int] NULL,
    CONSTRAINT [PK__Enrollme__7F6877FB6F6380D8] PRIMARY KEY CLUSTERED
(
[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Experts]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Experts](
    [ExpertID] [int] IDENTITY(1,1) NOT NULL,
    [Bio] [nvarchar](max) NULL,
    [ExperienceYears] [int] NULL,
    [ProfileImage] [nvarchar](255) NULL,
    [CreatedDate] [datetime] NULL,
    [Status] [bit] NULL,
    [UserID] [int] NULL,
    CONSTRAINT [PK__Experts__7EDB3A380C5740EF] PRIMARY KEY CLUSTERED
(
[ExpertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[LessonFile]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[LessonFile](
    [LessonID] [int] NOT NULL,
    [FileUrl] [nvarchar](max) NULL,
    [FileType] [nchar](50) NULL,
    [FileSize] [int] NULL
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[LessonQuiz]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[LessonQuiz](
    [LessonQuizID] [int] IDENTITY(1,1) NOT NULL,
    [LessonID] [int] NOT NULL,
    [PassPercentage] [int] NULL,
    [TimeLimit] [int] NULL,
    [AttemptAllowed] [int] NULL,
    [Status] [bit] NULL,
    [ImageUrl] [nvarchar](max) NULL,
    [Mp3Url] [nvarchar](max) NULL,
    CONSTRAINT [PK_LessonQuiz] PRIMARY KEY CLUSTERED
(
[LessonQuizID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Lessons]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Lessons](
    [LessonID] [int] IDENTITY(1,1) NOT NULL,
    [SubjectID] [int] NOT NULL,
    [LessonName] [nvarchar](100) NOT NULL,
    [Content] [nvarchar](max) NULL,
    [Duration] [int] NULL,
    [OrderNo] [int] NULL,
    [status_lesson] [bit] NULL,
    [CreatedDate] [datetime] NULL,
    [Type] [nvarchar](50) NULL,
    [UpdateDate] [datetime] NULL,
    CONSTRAINT [PK__Lessons__B084ACB09084DE14] PRIMARY KEY CLUSTERED
(
[LessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[LessonText]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[LessonText](
    [LessonID] [int] NOT NULL,
    [Content] [nvarchar](max) NULL
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[LessonVideo]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[LessonVideo](
    [LessonID] [int] NOT NULL,
    [VideoUrl] [nvarchar](max) NOT NULL,
    [VideoDuration] [int] NULL,
    [Transcript] [nvarchar](max) NULL,
    [DownloadAllowed] [bit] NULL
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Marketing]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Marketing](
    [MarketingID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NULL,
    [ExperienceYears] [int] NULL,
    CONSTRAINT [PK__Marketin__4CCE5A4FD3CF0B71] PRIMARY KEY CLUSTERED
(
[MarketingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Notificaion]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Notificaion](
    [NotificationID] [int] NOT NULL,
    [UserID] [int] NULL,
    [message] [text] NULL,
    [messageDate] [datetime] NULL,
     CONSTRAINT [PK__Notifica__20CF2E320687D44C] PRIMARY KEY CLUSTERED
    (
[NotificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[PostReview]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[PostReview](
    [PostReviewID] [int] NOT NULL,
    [PostID] [int] NOT NULL,
    [CustomerID] [int] NOT NULL,
    [Rating] [float] NULL,
    [Comment] [nvarchar](max) NULL,
    [ReviewDate] [datetime] NULL,
    [Status] [bit] NULL,
    PRIMARY KEY CLUSTERED
(
[PostReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Posts]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Posts](
    [PostID] [int] IDENTITY(1,1) NOT NULL,
    [CategoryBlogID] [int] NULL,
    [MarketingID] [int] NULL,
    [Title] [nvarchar](max) NULL,
    [Content] [nvarchar](max) NULL,
    [Thumbnail] [varchar](255) NULL,
    [CreateDate] [datetime] NULL,
    [Amount_View] [int] NULL,
    [PostFile] [nvarchar](255) NULL,
    [UpdateDate] [datetime] NULL,
    [Status] [bit] NULL,
    CONSTRAINT [PK__Posts__AA12603874A9032C] PRIMARY KEY CLUSTERED
(
[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[PriceCourse]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[PriceCourse](
    [PriceID] [int] IDENTITY(1,1) NOT NULL,
    [CourseID] [int] NULL,
    [PriceName] [nvarchar](255) NULL,
    [AccessDuration] [int] NULL,
    [Price] [float] NULL,
    [SalePrice] [float] NULL,
    [Status] [bit] NULL,
    [Description] [nvarchar](255) NULL,
    PRIMARY KEY CLUSTERED
(
[PriceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Question]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Question](
    [QuestionID] [int] IDENTITY(1,1) NOT NULL,
    [Content] [nvarchar](max) NULL,
    [Level] [int] NULL,
    [SubjectId] [int] NOT NULL,
    [Mark] [int] NULL,
    [QuestionTypeID] [int] NOT NULL,
    [IsActive] [bit] NULL,
    [CreateAt] [datetime] NULL,
    [UpdateAt] [datetime] NULL,
    [Mp3] [nvarchar](max) NULL,
    CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED
(
[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[QuestionAnswer]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[QuestionAnswer](
    [AnswerID] [int] IDENTITY(1,1) NOT NULL,
    [SortOrder] [int] NOT NULL,
    [Content] [nvarchar](max) NOT NULL,
    [QuestionID] [int] NOT NULL,
    [IsCorrect] [bit] NOT NULL,
    CONSTRAINT [PK_QuestionAnswer] PRIMARY KEY CLUSTERED
(
[AnswerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[QuestionImages]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[QuestionImages](
    [ImageID] [int] IDENTITY(1,1) NOT NULL,
    [ImageTitle] [nvarchar](50) NULL,
    [ImageURL] [nvarchar](max) NULL,
    [QuestionImageID] [int] NULL,
    CONSTRAINT [PK_QuestionImages] PRIMARY KEY CLUSTERED
(
[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[QuestionType]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[QuestionType](
    [QuestionTypeID] [int] IDENTITY(1,1) NOT NULL,
    [QuestionTypeName] [nchar](50) NULL,
    CONSTRAINT [PK_QuestionType] PRIMARY KEY CLUSTERED
(
[QuestionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[QuizAttend]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[QuizAttend](
    [QuizAttendID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [LessonQuizID] [int] NOT NULL,
    [Score] [decimal](5, 2) NULL,
    [Passed] [bit] NULL,
    [StartTime] [datetime] NULL,
    [EndTime] [datetime] NULL,
    CONSTRAINT [PK_QuizAttend] PRIMARY KEY CLUSTERED
(
[QuizAttendID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[QuizQuestions]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[QuizQuestions](
    [QuizQuestionID] [int] IDENTITY(1,1) NOT NULL,
    [QuestionID] [int] NOT NULL,
    [SortOrder] [int] NULL,
    [LessonQuizID] [int] NULL,
    CONSTRAINT [PK_QuizQuestions] PRIMARY KEY CLUSTERED
(
[QuizQuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[QuizResultDetailDAO]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[QuizResultDetail](
    [QuizResultDetailID] [int] IDENTITY(1,1) NOT NULL,
    [QuizAttendID] [int] NOT NULL,
    [QuestionID] [int] NOT NULL,
    [ChooseOptionID] [int] NULL,
    [IsCorrect] [bit] NULL,
    [AnswerText] [nvarchar](max) NULL,
    [ImageQuizID] [int] NULL,
    CONSTRAINT [PK_QuizResultDetail] PRIMARY KEY CLUSTERED
(
[QuizResultDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[QuizResultDetailImage]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[QuizResultDetailImage](
    [ImageID] [int] IDENTITY(1,1) NOT NULL,
    [ImageQuizID] [int] NULL,
    [Title] [nchar](100) NULL,
    CONSTRAINT [PK_QuizResultDetailImage] PRIMARY KEY CLUSTERED
(
[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[ReviewCourse]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[ReviewCourse](
    [ReviewCourseID] [int] IDENTITY(1,1) NOT NULL,
    [CourseID] [int] NOT NULL,
    [CustomerID] [int] NOT NULL,
    [Rating] [float] NULL,
    [Comment] [nvarchar](max) NULL,
    [ReviewDate] [datetime] NULL,
    [ReviewFeedback] [nvarchar](max) NULL,
    [Status] [bit] NULL,
    CONSTRAINT [PK__Reviews__74BC79AE3D9D7FD6] PRIMARY KEY CLUSTERED
(
[ReviewCourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[ReviewLesson]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[ReviewLesson](
    [ReviewLessonID] [int] IDENTITY(1,1) NOT NULL,
    [LessonID] [int] NOT NULL,
    [CustomerID] [int] NOT NULL,
    [ReviewDate] [datetime] NULL,
    [Status] [bit] NULL,
    [Comment] [nvarchar](max) NULL,
    PRIMARY KEY CLUSTERED
(
[ReviewLessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Roles](
    [RoleID] [int] NOT NULL,
    [RoleName] [nvarchar](50) NOT NULL,
    PRIMARY KEY CLUSTERED
(
[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Sales]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Sales](
    [SaleID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NULL,
    [ExperienceYears] [int] NULL,
    PRIMARY KEY CLUSTERED
(
[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Setting]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Setting](
    [settingID] [int] IDENTITY(1,1) NOT NULL,
    [type] [nvarchar](255) NULL,
    [value] [nvarchar](255) NULL,
    [order] [int] NULL,
    [status] [bit] NULL,
    [createdAt] [datetime] NULL,
    [updatedAt] [datetime] NULL,
    [description] [nvarchar](max) NULL,
    PRIMARY KEY CLUSTERED
(
[settingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Sliders]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Sliders](
    [SliderID] [int] IDENTITY(1,1) NOT NULL,
    [Slider_url] [varchar](255) NULL,
    [MarketingID] [int] NULL,
    [Title] [nvarchar](max) NOT NULL,
    [Image] [nvarchar](200) NULL,
    [Description] [nvarchar](max) NULL,
    [IsShow] [bit] NULL,
    [Content] [nvarchar](max) NULL,
    [CreateDate] [datetime] NULL,
    [UpdateDate] [datetime] NULL,
    [BackLink] [nvarchar](255) NULL,
    [Status] [bit] NULL,
    CONSTRAINT [PK__Sliders__24BC97105F791CCD] PRIMARY KEY CLUSTERED
(
[SliderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Subjects]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Subjects](
    [SubjectID] [int] IDENTITY(1,1) NOT NULL,
    [CourseID] [int] NOT NULL,
    [SubjectName] [nvarchar](100) NOT NULL,
    [Description] [nvarchar](max) NULL,
    [OrderNo] [int] NULL,
    [CreatedDate] [datetime] NULL,
    CONSTRAINT [PK__Subjects__AC1BA388419824F6] PRIMARY KEY CLUSTERED
(
[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/20/2025 12:47:27 AM ******/
    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
CREATE TABLE [dbo].[Users](
    [UserID] [int] IDENTITY(1,1) NOT NULL,
    [Username] [nvarchar](50) NOT NULL,
    [FirstName] [nvarchar](100) NOT NULL,
    [LastName] [nvarchar](100) NOT NULL,
    [Password] [nvarchar](255) NOT NULL,
    [Email] [nvarchar](100) NOT NULL,
    [PhoneNumber] [nvarchar](12) NOT NULL,
    [CreatedDate] [datetime] NULL,
    [Gender] [nvarchar](10) NULL,
    [Avatar] [nvarchar](max) NULL,
    [Age] [int] NOT NULL,
    [RoleID] [int] NULL,
    [Status] [bit] NULL,
    CONSTRAINT [PK__Users__1788CCAC37CCF769] PRIMARY KEY CLUSTERED
(
[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (1, N'Học ngữ pháp')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (2, N'Luyện nghe - nói')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (3, N'Mẹo học tiếng Anh')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (4, N'Học từ vựng')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (5, N'Luyện viết')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (6, N'Chia sẻ kinh nghiệm học')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (7, N'Bí kíp thi cử')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (8, N'Câu chuyện & Bài đọc')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (9, N'Tin tức & sự kiện')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (10, N'Tài liệu & Sách học')
    GO
    INSERT [dbo].[CategoryBlog] ([CategoryBlogID], [CategoryBlogName]) VALUES (11, N'Vui học tiếng Anh')
    GO
    SET IDENTITY_INSERT [dbo].[CommentPost] ON
    GO
    INSERT [dbo].[CommentPost] ([CommentPostID], [ParentID], [PostID], [UserID], [Content], [CreateDate]) VALUES (1, NULL, 1, 2, N'Thật sự rất hữu ích! Cảm ơn bài viết.', CAST(N'2025-03-04T19:24:42.047' AS DateTime))
    GO
    INSERT [dbo].[CommentPost] ([CommentPostID], [ParentID], [PostID], [UserID], [Content], [CreateDate]) VALUES (2, NULL, 1, 3, N'Mình vẫn chưa hiểu rõ về thì quá khứ hoàn thành.', CAST(N'2025-03-04T19:24:42.047' AS DateTime))
    GO
    INSERT [dbo].[CommentPost] ([CommentPostID], [ParentID], [PostID], [UserID], [Content], [CreateDate]) VALUES (3, 1, 1, 6, N'Mình cũng thấy vậy. Tác giả viết rất chi tiết.', CAST(N'2025-03-04T19:24:42.053' AS DateTime))
    GO
    INSERT [dbo].[CommentPost] ([CommentPostID], [ParentID], [PostID], [UserID], [Content], [CreateDate]) VALUES (4, 2, 1, 7, N'Bạn có thể xem phần ví dụ trong bài nhé.', CAST(N'2025-03-04T19:24:42.053' AS DateTime))
    GO
    INSERT [dbo].[CommentPost] ([CommentPostID], [ParentID], [PostID], [UserID], [Content], [CreateDate]) VALUES (5, 3, 1, 2, N'Đúng rồi! Rất dễ hiểu, đặc biệt là phần bài tập.', CAST(N'2025-03-04T19:24:42.057' AS DateTime))
    GO
    INSERT [dbo].[CommentPost] ([CommentPostID], [ParentID], [PostID], [UserID], [Content], [CreateDate]) VALUES (6, 4, 1, 3, N'Ok mình sẽ đọc lại, cảm ơn bạn.', CAST(N'2025-03-04T19:24:42.057' AS DateTime))
    GO
    INSERT [dbo].[CommentPost] ([CommentPostID], [ParentID], [PostID], [UserID], [Content], [CreateDate]) VALUES (8, 1, 1, 1, N'ok', CAST(N'2025-03-05T13:28:11.207' AS DateTime))
    GO
    SET IDENTITY_INSERT [dbo].[CommentPost] OFF
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (1, N'English for Beginners')
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (2, N'Business English')
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (3, N'Conversational English')
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (4, N'IELTS Preparation')
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (5, N'TOEFL Preparation')
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (6, N'English for Kids')
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (7, N'English Grammar')
    GO
    INSERT [dbo].[Course_Type] ([course_typeId], [course_typeName]) VALUES (8, N'Advanced English')
    GO
    SET IDENTITY_INSERT [dbo].[Courses] ON
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (1, 1, N'Basic English A1', N'Khóa học dành cho người mới bắt đầu học tiếng Anh từ con số 0.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 49.99, N'Learn English from Scratch', N'basic_a1.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (2, 1, N'Essential English A2', N'Củng cố các kỹ năng cơ bản như từ vựng, ngữ pháp và phát âm.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 59.99, N'Improve Your Basic English', N'essential_a2.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (3, 2, N'English for Emails', N'Học cách viết email chuyên nghiệp bằng tiếng Anh.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 79.99, N'Master Email Communication', N'email_english.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (4, 2, N'English for Meetings', N'Nâng cao kỹ năng giao tiếp trong các cuộc họp quốc tế.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 89.99, N'Fluent in Business Meetings', N'meeting_english.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (5, 2, N'English for Presentations', N'Kỹ năng thuyết trình chuyên nghiệp bằng tiếng Anh.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 99.99, N'Confident Business Presentations', N'presentation_english.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (6, 3, N'Daily English Conversations', N'Thực hành các hội thoại tiếng Anh hàng ngày.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 39.99, N'Speak English Naturally', N'daily_convo.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (7, 3, N'English for Travelers', N'Giao tiếp tự tin khi đi du lịch nước ngoài.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 49.99, N'Travel with Confidence', N'travel_english.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (8, 4, N'IELTS Listening Mastery', N'Luyện kỹ năng nghe để đạt điểm cao IELTS.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 109.99, N'Boost Your IELTS Listening Score', N'ielts_listening.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (9, 4, N'IELTS Writing Strategies', N'Học cách viết bài Task 1 và Task 2 hiệu quả.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 129.99, N'Perfect Your IELTS Writing', N'ielts_writing.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (10, 4, N'IELTS Speaking Confidence', N'Luyện tập phản xạ nói nhanh và tự nhiên.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 119.99, N'Speak Fluently in IELTS', N'ielts_speaking.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (11, 5, N'TOEFL Reading Skills', N'Chiến thuật làm bài đọc hiệu quả.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 99.99, N'Master TOEFL Reading', N'toefl_reading.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (12, 5, N'TOEFL Writing Techniques', N'Cách viết bài luận đạt điểm cao.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 109.99, N'Improve Your TOEFL Writing', N'toefl_writing.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (13, 6, N'Fun English for Kids', N'Học tiếng Anh qua trò chơi và bài hát.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 29.99, N'Interactive English for Children', N'kids_fun.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (14, 6, N'Phonics and Pronunciation', N'Cách phát âm chuẩn cho trẻ em.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 39.99, N'Learn Phonics Easily', N'kids_phonics.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (15, 7, N'Grammar Essentials', N'Hệ thống lại tất cả các điểm ngữ pháp quan trọng.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 49.99, N'Master English Grammar', N'grammar_essentials.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (16, 7, N'Advanced Grammar Workshop', N'Các cấu trúc nâng cao và cách dùng.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 59.99, N'Grammar for Proficiency', N'grammar_advanced.jpg', 2, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (17, 8, N'Academic English Writing', N'Viết luận và báo cáo chuyên sâu.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 129.99, N'Write Like an Academic', N'academic_writing.jpg', 1, 1)
    GO
    INSERT [dbo].[Courses] ([CourseID], [course_typeId], [CourseName], [Description], [CreatedDate], [Price], [title], [thumbnail], [ExpertID], [status]) VALUES (18, 8, N'English for Debating', N'Luyện tập tranh luận bằng tiếng Anh chuyên nghiệp.', CAST(N'2025-03-03T03:42:43.547' AS DateTime), 89.99, N'Master Debating Skills', N'english_debate.jpg', 2, 1)
    GO
    SET IDENTITY_INSERT [dbo].[Courses] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Customers] ON
    GO
    INSERT [dbo].[Customers] ([CustomerID], [SocialRole], [LevelOfEnglish], [UserID]) VALUES (1, N'Student', N'Beginner', 2)
    GO
    INSERT [dbo].[Customers] ([CustomerID], [SocialRole], [LevelOfEnglish], [UserID]) VALUES (2, N'Student', N'Intermediate', 3)
    GO
    SET IDENTITY_INSERT [dbo].[Customers] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Enrollments] ON
    GO
    INSERT [dbo].[Enrollments] ([EnrollmentID], [EnrollDate], [Status], [Pay_Code], [Process_Percentage], [CustomerID], [CourseID]) VALUES (1, CAST(N'2025-03-03T15:16:52.530' AS DateTime), NULL, NULL, NULL, 1, 1)
    GO
    INSERT [dbo].[Enrollments] ([EnrollmentID], [EnrollDate], [Status], [Pay_Code], [Process_Percentage], [CustomerID], [CourseID]) VALUES (2, CAST(N'2025-03-03T15:17:03.287' AS DateTime), NULL, NULL, NULL, NULL, 2)
    GO
    SET IDENTITY_INSERT [dbo].[Enrollments] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Experts] ON
    GO
    INSERT [dbo].[Experts] ([ExpertID], [Bio], [ExperienceYears], [ProfileImage], [CreatedDate], [Status], [UserID]) VALUES (1, N'Experienced English teacher with 10 years of teaching.', 10, N'expert1.jpg', NULL, NULL, 4)
    GO
    INSERT [dbo].[Experts] ([ExpertID], [Bio], [ExperienceYears], [ProfileImage], [CreatedDate], [Status], [UserID]) VALUES (2, N'English tutor with 15 years of experience in education.', 15, N'expert2.jpg', NULL, NULL, 5)
    GO
    SET IDENTITY_INSERT [dbo].[Experts] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Marketing] ON
    GO
    INSERT [dbo].[Marketing] ([MarketingID], [UserID], [ExperienceYears]) VALUES (1, 8, 4)
    GO
    INSERT [dbo].[Marketing] ([MarketingID], [UserID], [ExperienceYears]) VALUES (2, 9, 6)
    GO
    SET IDENTITY_INSERT [dbo].[Marketing] OFF
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (1, 1, 1, 5, N'Bài viết rất hữu ích, giúp mình hiểu rõ về các thì trong tiếng Anh!', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (2, 1, 2, 2, N'Nội dung đầy đủ nhưng nên có thêm bài tập minh họa.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (3, 2, 1, 5, N'Giải thích dễ hiểu, áp dụng vào bài tập rất hiệu quả.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (4, 2, 2, 4, N'Bài viết hay nhưng cần thêm ví dụ thực tế.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (5, 3, 1, 5, N'Cung cấp kiến thức hữu ích về câu điều kiện, rất thích!', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (6, 3, 2, 3, N'Tốt nhưng nên có thêm bài tập thực hành.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (7, 4, 1, 4, N'Mình thích phương pháp luyện nghe qua phim hoạt hình!', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (8, 4, 2, 3, N'Hữu ích, nhưng có thể bổ sung thêm danh sách phim phù hợp.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (9, 5, 1, 5, N'Bài luyện nghe rất phù hợp cho người mới bắt đầu.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (10, 5, 2, 4, N'Nghe dễ hiểu và có transcript chi tiết.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (11, 6, 1, 5, N'Phát âm chuẩn là rất quan trọng, bài viết đã giúp mình nhiều.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (12, 6, 2, 4, N'Mình thích bài này nhưng mong có thêm video minh họa.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (13, 7, 1, 4, N'Lộ trình học tiếng Anh rõ ràng, rất hữu ích!', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (14, 7, 2, 3, N'Nội dung tốt nhưng nên chia nhỏ thành từng bước cụ thể hơn.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (15, 8, 1, 5, N'Học từ vựng mỗi ngày rất hiệu quả.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (16, 8, 2, 4, N'Mình đã thử và thấy tiến bộ đáng kể!', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (17, 9, 1, 4, N'Bài viết giúp mình nhận ra những lỗi sai thường gặp khi học.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (18, 9, 2, 3, N'Rất thực tế, nhưng cần có thêm cách khắc phục lỗi sai.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (19, 10, 1, 5, N'Rất hay! Mình đã áp dụng và thấy hiệu quả ngay.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (20, 10, 2, 4, N'Nội dung chất lượng, nhưng cần có thêm ví dụ.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (21, 11, 1, 4, N'Bài viết giúp mình học từ vựng dễ dàng hơn.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (22, 11, 2, 3, N'Hay nhưng phần bài tập chưa phong phú lắm.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (23, 12, 1, 5, N'Cách học rất mới mẻ, mình rất thích!', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (24, 12, 2, 4, N'Có thể bổ sung thêm hướng dẫn thực hành.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (25, 13, 1, 5, N'Bài viết rất thực tế và hữu ích.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (26, 13, 2, 4, N'Rất đáng đọc, mong có thêm phần bài tập.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (27, 14, 1, 4, N'Mình thấy bài viết này khá dễ hiểu.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (28, 14, 2, 3, N'Có thể làm chi tiết hơn ở một số phần.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (29, 15, 1, 5, N'Một bài viết rất hay, mình đã áp dụng ngay.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    INSERT [dbo].[PostReview] ([PostReviewID], [PostID], [CustomerID], [Rating], [Comment], [ReviewDate], [Status]) VALUES (30, 15, 2, 4, N'Cảm ơn tác giả! Nội dung rất hữu ích.', CAST(N'2025-03-03T03:42:43.557' AS DateTime), 1)
    GO
    SET IDENTITY_INSERT [dbo].[Posts] ON
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (1, 1, 1, N'Các thì trong tiếng Anh - Tổng hợp đầy đủ', N'Hướng dẫn chi tiết 12 thì trong tiếng Anh...', N'grammar_tenses.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1200, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (2, 1, 1, N'Sự khác biệt giữa ''a'', ''an'' và ''the''', N'Cách sử dụng đúng mạo từ trong tiếng Anh...', N'articles_usage.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 980, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (3, 1, 2, N'Cách sử dụng câu điều kiện chuẩn xác', N'Tìm hiểu các loại câu điều kiện và cách dùng...', N'conditional_sentences.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 850, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (4, 2, 2, N'Luyện nghe qua phim hoạt hình', N'Học tiếng Anh qua phim hoạt hình giúp cải thiện kỹ năng nghe...', N'listening_cartoons.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1500, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (5, 2, 1, N'10 bài luyện nghe cơ bản cho người mới', N'Những bài nghe đơn giản giúp bạn làm quen với tiếng Anh...', N'basic_listening.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1100, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (6, 2, 2, N'Luyện phát âm chuẩn như người bản xứ', N'Các mẹo giúp bạn phát âm đúng chuẩn...', N'pronunciation_tips.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 900, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (7, 3, 1, N'Cách học tiếng Anh hiệu quả trong 3 tháng', N'Lộ trình học tiếng Anh dành cho người bận rộn...', N'study_tips.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1400, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (8, 3, 2, N'Học 5 từ vựng mới mỗi ngày', N'Phương pháp giúp bạn ghi nhớ từ vựng hiệu quả...', N'vocab_learning.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1150, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (9, 3, 1, N'Tại sao bạn học mãi mà không tiến bộ?', N'Những sai lầm phổ biến khi học tiếng Anh...', N'common_mistakes.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 870, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (10, 4, 2, N'1000 từ vựng thông dụng trong giao tiếp', N'Danh sách từ vựng cơ bản giúp bạn giao tiếp tự nhiên...', N'common_vocab.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1700, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (11, 4, 1, N'Học từ vựng qua hình ảnh', N'Phương pháp học từ vựng sinh động và dễ nhớ...', N'vocab_pictures.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1250, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (12, 4, 2, N'Cách ghi nhớ từ vựng nhanh và lâu', N'Ứng dụng kỹ thuật ghi nhớ từ vựng vào thực tế...', N'memory_tricks.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1000, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (13, 5, 1, N'Cách viết email chuyên nghiệp bằng tiếng Anh', N'Hướng dẫn từng bước viết email...', N'email_writing.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1600, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (14, 5, 2, N'Mẹo viết luận tiếng Anh đạt điểm cao', N'Các bước quan trọng khi viết essay...', N'essay_tips.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 900, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (15, 5, 1, N'Học viết câu phức dễ dàng', N'Cách tạo câu phức đúng ngữ pháp...', N'complex_sentences.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 800, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (16, 6, 2, N'Làm sao để học tiếng Anh khi không có môi trường?', N'Cách tự tạo môi trường học tiếng Anh cho bản thân...', N'self_learning.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1400, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (17, 6, 1, N'Chia sẻ của một người đạt IELTS 8.0', N'Câu chuyện học tiếng Anh từ một cao thủ...', N'ielts_success.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1100, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (18, 6, 2, N'Từ mất gốc đến giao tiếp thành thạo', N'Hành trình học tiếng Anh từ con số 0...', N'from_zero_to_fluent.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 900, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (19, 7, 1, N'Chiến thuật làm bài IELTS Reading', N'Cách làm bài đọc hiệu quả và tiết kiệm thời gian...', N'ielts_reading_tips.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1300, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (20, 7, 2, N'Cách phân bổ thời gian khi thi TOEIC', N'Làm sao để hoàn thành bài thi TOEIC trong thời gian cho phép...', N'toeic_time_management.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1200, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (21, 7, 1, N'Những lỗi sai cần tránh khi thi Speaking', N'Những lỗi khiến bạn mất điểm khi thi IELTS Speaking...', N'speaking_mistakes.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1100, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (22, 8, 2, N'Câu chuyện ngắn giúp bạn học từ vựng', N'Những truyện ngắn thú vị giúp bạn học từ vựng dễ dàng...', N'short_story_vocab.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1000, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (23, 8, 1, N'Bài đọc nâng cao kèm bài tập', N'Bộ sưu tập bài đọc kèm câu hỏi kiểm tra...', N'reading_exercises.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 950, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (24, 8, 2, N'Truyện ngắn tiếng Anh cho người mới bắt đầu', N'Những câu chuyện đơn giản giúp bạn luyện đọc...', N'beginner_stories.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 870, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (25, 9, 1, N'Những thay đổi mới trong kỳ thi IELTS 2024', N'Cập nhật những thay đổi mới nhất trong bài thi...', N'ielts_changes.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1800, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (26, 9, 2, N'Hội thảo học tiếng Anh miễn phí tháng này', N'Danh sách các hội thảo hỗ trợ học tiếng Anh...', N'free_english_workshop.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1400, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (27, 9, 1, N'Học bổng du học Anh 2024', N'Thông tin về học bổng và cách ứng tuyển...', N'uk_scholarships.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1200, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (28, 10, 2, N'Top 5 cuốn sách học IELTS hay nhất', N'Danh sách sách giúp bạn đạt điểm cao trong kỳ thi...', N'ielts_books.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1600, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (29, 10, 1, N'Tài liệu học TOEFL miễn phí', N'Tổng hợp tài liệu giúp bạn ôn luyện hiệu quả...', N'toefl_resources.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1300, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (30, 10, 2, N'Bộ tài liệu học tiếng Anh cho người mới bắt đầu', N'Tài liệu giúp bạn học từ cơ bản đến nâng cao...', N'beginner_materials.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1100, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (31, 11, 1, N'Học tiếng Anh qua meme vui nhộn', N'Học từ vựng và ngữ pháp qua các meme hài hước...', N'funny_memes.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1400, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (32, 11, 2, N'10 câu đố tiếng Anh thú vị', N'Những câu đố giúp bạn vừa học vừa chơi...', N'english_riddles.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1300, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    INSERT [dbo].[Posts] ([PostID], [CategoryBlogID], [MarketingID], [Title], [Content], [Thumbnail], [CreateDate], [Amount_View], [PostFile], [UpdateDate], [Status]) VALUES (33, 11, 1, N'Luyện tiếng Anh qua bài hát', N'Học tiếng Anh thông qua lời bài hát...', N'learn_through_songs.jpg', CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1200, NULL, CAST(N'2025-03-03T03:42:43.553' AS DateTime), 1)
    GO
    SET IDENTITY_INSERT [dbo].[Posts] OFF
    GO
    SET IDENTITY_INSERT [dbo].[PriceCourse] ON
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (1, 1, N'Gói Co B?n', 30, 199.99, 149.99, 1, N'Gói h?c co b?n trong 30 ngày')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (2, 2, N'Gói Nâng Cao', 60, 299.99, 249.99, 1, N'Gói h?c nâng cao trong 60 ngày')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (3, 3, N'Gói Chuyên Sâu', 90, 399.99, 299.99, 1, N'Gói chuyên sâu trong 90 ngày')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (4, 4, N'Gói Premium', 180, 599.99, 499.99, 1, N'Gói h?c tr?n d?i v?i uu dãi')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (5, 5, N'Gói Th? Nghi?m', 7, 49.99, 39.99, 1, N'Tr?i nghi?m khóa h?c trong 7 ngày')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (6, 6, N'Gói Ð?c Bi?t', 365, 999.99, 799.99, 1, N'Gói h?c c? nam v?i giá uu dãi')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (7, 7, N'Gói H?c 1 Tháng', 30, 199.99, 159.99, 1, N'H?c trong 1 tháng')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (8, 8, N'Gói H?c 3 Tháng', 90, 499.99, 399.99, 1, N'H?c trong 3 tháng')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (9, 9, N'Gói H?c 6 Tháng', 180, 799.99, 599.99, 1, N'H?c trong 6 tháng')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (10, 10, N'Gói Full Access', NULL, 1299.99, 999.99, 1, N'Truy c?p không gi?i h?n')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (11, 11, N'Gói Beginner', 30, 179.99, 129.99, 1, N'Khóa h?c co b?n dành cho ngu?i m?i')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (12, 12, N'Gói Intermediate', 60, 279.99, 219.99, 1, N'Khóa h?c trung c?p cho ngu?i có kinh nghi?m')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (13, 13, N'Gói Advanced', 90, 379.99, 299.99, 1, N'Khóa h?c nâng cao')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (14, 14, N'Gói Chuyên Nghi?p', 180, 579.99, 479.99, 1, N'Dành cho chuyên gia trong ngành')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (15, 15, N'Gói VIP', 365, 1099.99, 899.99, 1, N'Gói VIP v?i h? tr? d?c bi?t')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (16, 16, N'Gói Express', 15, 129.99, 99.99, 1, N'H?c nhanh trong 15 ngày')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (17, 17, N'Gói Ultimate', NULL, 1499.99, 1199.99, 1, N'Gói cao c?p nh?t v?i quy?n l?i d?c bi?t')
    GO
    INSERT [dbo].[PriceCourse] ([PriceID], [CourseID], [PriceName], [AccessDuration], [Price], [SalePrice], [Status], [Description]) VALUES (18, 18, N'Gói Corporate', NULL, 4999.99, 3999.99, 1, N'Gói dành cho doanh nghi?p')
    GO
    SET IDENTITY_INSERT [dbo].[PriceCourse] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Question] ON
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (1, N'What is the correct form of the verb "to be" in the present tense for "she"?', 1, 2, 1, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), CAST(N'2025-03-20T00:22:37.163' AS DateTime), NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (2, N'Choose the correct sentence:', 2, 2, 2, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), CAST(N'2025-03-20T00:04:44.633' AS DateTime), NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (3, N'The word "book" is a:', 1, 1, 1, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (4, N'Listen to the audio and select the correct answer.', 3, 3, 3, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (5, N'The past tense of "go" is:', 2, 2, 1, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (6, N'Business emails should always include a formal greeting. True or False?', 1, 7, 1, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (7, N'Fill in the blank: "I _____ to the store yesterday."', 2, 2, 2, 2, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (8, N'Select the correct definition for the word "diligent":', 2, 5, 3, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (9, N'Fill in the blank: "She _____ English for five years now."', 3, 2, 5, 2, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (10, N'Choose the best description of the image:', 2, 15, 3, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (11, N'Select the correct interpretation of the chart showing English proficiency trends:', 3, 22, 5, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    INSERT [dbo].[Question] ([QuestionID], [Content], [Level], [SubjectId], [Mark], [QuestionTypeID], [IsActive], [CreateAt], [UpdateAt], [Mp3]) VALUES (12, N'Identify the correct pronunciation of these words based on the phonetic symbols:', 2, 6, 2, 1, 1, CAST(N'2025-03-17T13:42:27.797' AS DateTime), NULL, NULL)
    GO
    SET IDENTITY_INSERT [dbo].[Question] OFF
    GO
    SET IDENTITY_INSERT [dbo].[QuestionAnswer] ON
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (9, 1, N'Verb', 3, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (10, 2, N'Adjective', 3, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (11, 3, N'Noun', 3, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (12, 4, N'Adverb', 3, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (13, 1, N'They are discussing a business proposal', 4, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (14, 2, N'They are planning a vacation', 4, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (15, 3, N'They are arguing about politics', 4, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (16, 4, N'They are talking about the weather', 4, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (17, 1, N'goed', 5, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (18, 2, N'went', 5, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (19, 3, N'gone', 5, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (20, 4, N'going', 5, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (21, 1, N'True', 6, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (22, 2, N'False', 6, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (23, 1, N'went', 7, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (24, 1, N'Lazy or slow to act', 8, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (25, 2, N'Hard-working and attentive', 8, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (26, 3, N'Careless or negligent', 8, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (27, 4, N'Intelligent or clever', 8, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (28, 1, N'has been studying', 9, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (29, 1, N'A family having dinner together', 10, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (30, 2, N'A person working at a computer', 10, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (31, 3, N'Children playing in a park', 10, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (32, 4, N'A cityscape at night', 10, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (33, 1, N'English proficiency has decreased globally', 11, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (34, 2, N'English proficiency has remained stable', 11, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (35, 3, N'English proficiency has increased in most regions', 11, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (36, 4, N'English is being replaced by other languages', 11, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (37, 1, N'/æ/ as in "cat"', 12, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (38, 2, N'/e/ as in "bed"', 12, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (39, 3, N'/ə/ as in "about"', 12, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (40, 4, N'/ʌ/ as in "cup"', 12, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (53, 1, N'She doesn''t likes coffee.', 2, 0)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (54, 2, N'She doesn''t like coffee.', 2, 1)
    GO
    INSERT [dbo].[QuestionAnswer] ([AnswerID], [SortOrder], [Content], [QuestionID], [IsCorrect]) VALUES (55, 3, N'She not like coffee.', 2, 0)
    GO
    SET IDENTITY_INSERT [dbo].[QuestionAnswer] OFF
    GO
    SET IDENTITY_INSERT [dbo].[QuestionImages] ON
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (1, N'Person working at computer', NULL, 10)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (2, N'Office environment', NULL, 10)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (3, N'English vocabulary exercise', NULL, 8)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (4, N'Person listening to audio', NULL, 4)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (5, N'English grammar exercise', NULL, 9)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (6, N'English proficiency chart', NULL, 11)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (7, N'Language learning trends', NULL, 11)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (8, N'Global English usage statistics', NULL, 11)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (9, N'Phonetic symbols chart', NULL, 12)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (10, N'Pronunciation guide', NULL, 12)
    GO
    INSERT [dbo].[QuestionImages] ([ImageID], [ImageTitle], [ImageURL], [QuestionImageID]) VALUES (11, N'1742401189567_score.jpg', NULL, 1)
    GO
    SET IDENTITY_INSERT [dbo].[QuestionImages] OFF
    GO
    SET IDENTITY_INSERT [dbo].[QuestionType] ON
    GO
    INSERT [dbo].[QuestionType] ([QuestionTypeID], [QuestionTypeName]) VALUES (1, N'MultipleChoice                                    ')
    GO
    INSERT [dbo].[QuestionType] ([QuestionTypeID], [QuestionTypeName]) VALUES (2, N'Fill in the blank                                 ')
    GO
    SET IDENTITY_INSERT [dbo].[QuestionType] OFF
    GO
    SET IDENTITY_INSERT [dbo].[ReviewCourse] ON
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (1, 1, 1, 5, N'Khóa học rất hữu ích cho người mới bắt đầu!', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn đã đánh giá!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (2, 1, 2, 4, N'Giáo trình khá dễ hiểu, nhưng cần thêm bài tập.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ cải thiện!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (3, 2, 1, 4, N'Khóa học giúp tôi cải thiện kỹ năng cơ bản.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (4, 2, 2, 3, N'Nội dung ổn nhưng hơi nhanh với người mới.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ xem xét điều chỉnh.', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (5, 3, 1, 5, N'Cách viết email chuyên nghiệp hơn rất nhiều sau khóa học này.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Rất vui khi bạn hài lòng!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (6, 3, 2, 4, N'Bài giảng hữu ích nhưng cần thêm ví dụ thực tế.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Sẽ có thêm cập nhật sắp tới!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (7, 4, 1, 5, N'Tôi cảm thấy tự tin hơn khi tham gia các cuộc họp bằng tiếng Anh.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúc mừng bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (8, 4, 2, 4, N'Khóa học tốt nhưng cần nhiều tình huống thực tế hơn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn góp ý của bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (9, 5, 1, 5, N'Giảng viên giảng dạy rất tận tâm và dễ hiểu.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn đã đánh giá!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (10, 5, 2, 4, N'Khóa học khá hay nhưng cần thêm bài tập thực hành.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ bổ sung!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (11, 6, 1, 5, N'Học cách phát âm chuẩn giúp tôi tự tin hơn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi rất vui khi bạn thích!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (12, 6, 2, 3, N'Nội dung ổn nhưng cần thêm video minh họa.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ cập nhật thêm!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (13, 7, 1, 4, N'Khóa học khá hữu ích.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (14, 7, 2, 5, N'Giảng viên dạy rất dễ hiểu.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi rất vui khi bạn thích!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (15, 8, 1, 5, N'Học xong tôi tự tin giao tiếp hơn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúc mừng bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (16, 8, 2, 4, N'Bài tập hơi ít nhưng vẫn rất hữu ích.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ bổ sung!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (17, 9, 1, 3, N'Nội dung ổn nhưng cần cập nhật thêm.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn góp ý của bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (18, 9, 2, 5, N'Khóa học giúp tôi hiểu rõ hơn về ngữ pháp.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Rất tuyệt!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (19, 10, 1, 5, N'Khóa học rất hay và dễ hiểu.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (20, 10, 2, 4, N'Học online rất tiện lợi.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi rất vui khi bạn thích!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (21, 11, 1, 5, N'Phần phát âm rất chuẩn, dễ học.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Rất tuyệt!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (22, 11, 2, 4, N'Nội dung bổ ích, giảng viên thân thiện.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (23, 12, 1, 4, N'Học xong tôi có thể giao tiếp tốt hơn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúc mừng bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (24, 12, 2, 5, N'Khóa học giúp tôi cải thiện kỹ năng viết.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Rất vui khi bạn thích!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (25, 13, 1, 3, N'Khóa học tốt nhưng cần thêm ví dụ thực tế.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ bổ sung!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (26, 13, 2, 5, N'Cách dạy của giảng viên rất hấp dẫn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (27, 14, 1, 5, N'Tôi học được rất nhiều điều mới.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúc mừng bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (28, 14, 2, 4, N'Nội dung ổn nhưng cần nhiều bài tập hơn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ xem xét!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (29, 15, 1, 4, N'Học xong tôi tự tin viết email hơn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (30, 15, 2, 5, N'Khóa học giúp tôi mở rộng vốn từ vựng.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Rất tuyệt!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (31, 16, 1, 5, N'Bài giảng rất sinh động, dễ hiểu.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Rất vui khi bạn thích!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (32, 16, 2, 4, N'Cần thêm phần thực hành.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúng tôi sẽ bổ sung!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (33, 17, 1, 5, N'Tôi có thể nói tiếng Anh tự tin hơn.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Chúc mừng bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (34, 17, 2, 3, N'Nội dung hơi dài nhưng hữu ích.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn góp ý của bạn!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (35, 18, 1, 4, N'Khóa học giúp tôi cải thiện phát âm.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Rất tuyệt!', 1)
    GO
    INSERT [dbo].[ReviewCourse] ([ReviewCourseID], [CourseID], [CustomerID], [Rating], [Comment], [ReviewDate], [ReviewFeedback], [Status]) VALUES (36, 18, 2, 5, N'Giảng viên giảng rất hay.', CAST(N'2025-03-03T03:42:43.550' AS DateTime), N'Cảm ơn bạn!', 1)
    GO
    SET IDENTITY_INSERT [dbo].[ReviewCourse] OFF
    GO
    INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
    GO
    INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Customer')
    GO
    INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Expert')
    GO
    INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (4, N'Marketing')
    GO
    INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (5, N'Sale')
    GO
    SET IDENTITY_INSERT [dbo].[Sales] ON
    GO
    INSERT [dbo].[Sales] ([SaleID], [UserID], [ExperienceYears]) VALUES (1, 6, 5)
    GO
    INSERT [dbo].[Sales] ([SaleID], [UserID], [ExperienceYears]) VALUES (2, 7, 3)
    GO
    SET IDENTITY_INSERT [dbo].[Sales] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Setting] ON
    GO
    INSERT [dbo].[Setting] ([settingID], [type], [value], [order], [status], [createdAt], [updatedAt], [description]) VALUES (4, N'system', N'Maintenance mode hehehe', 4, 1, NULL, NULL, N'ddaay la transcrip')
    GO
    INSERT [dbo].[Setting] ([settingID], [type], [value], [order], [status], [createdAt], [updatedAt], [description]) VALUES (5, N'user', N'Notification settings', 5, 0, NULL, NULL, N'Cài d?t thông báo cho ngu?i dùng')
    GO
    INSERT [dbo].[Setting] ([settingID], [type], [value], [order], [status], [createdAt], [updatedAt], [description]) VALUES (13, N'user', N'aa', 1, 0, NULL, NULL, N'a')
    GO
    SET IDENTITY_INSERT [dbo].[Setting] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Sliders] ON
    GO
    INSERT [dbo].[Sliders] ([SliderID], [Slider_url], [MarketingID], [Title], [Image], [Description], [IsShow], [Content], [CreateDate], [UpdateDate], [BackLink], [Status]) VALUES (1, N'/sliders/ielts-7plus', 1, N'Chinh phục IELTS 7.0+ trong 3 tháng', N'assets/images/slider/slide1.jpg', N'Khóa học luyện thi IELTS chuyên sâu với lộ trình cá nhân hóa giúp bạn đạt điểm cao nhanh chóng.', 1, N'Đăng ký ngay để nhận ưu đãi giảm 30% học phí!', CAST(N'2025-03-03T04:02:29.650' AS DateTime), NULL, N'/courses/ielts', 1)
    GO
    INSERT [dbo].[Sliders] ([SliderID], [Slider_url], [MarketingID], [Title], [Image], [Description], [IsShow], [Content], [CreateDate], [UpdateDate], [BackLink], [Status]) VALUES (2, N'/sliders/english-speaking', 2, N'Giao tiếp tự tin với tiếng Anh trong 6 tuần', N'assets/images/slider/slide2.jpg', N'Khóa học tiếng Anh giao tiếp giúp bạn nói trôi chảy với phương pháp thực hành trực tiếp.', 1, N'Học thử miễn phí ngay hôm nay!', CAST(N'2025-03-03T04:02:29.650' AS DateTime), NULL, N'/courses/english-speaking', 1)
    GO
    INSERT [dbo].[Sliders] ([SliderID], [Slider_url], [MarketingID], [Title], [Image], [Description], [IsShow], [Content], [CreateDate], [UpdateDate], [BackLink], [Status]) VALUES (3, N'/sliders/toeic-exam', 1, N'Luyện thi TOEIC 750+ chỉ với 8 tuần', N'https://westlink.edu.vn/wp-content/uploads/2023/11/tai-sao-nen-cho-tre-hoc-tieng-anh-som-2.jpg', N'Phương pháp học TOEIC hiệu quả giúp bạn nâng cao điểm số và đạt mục tiêu nhanh chóng.', 1, N'Nhận tài liệu TOEIC miễn phí khi đăng ký khóa học ngay bây giờ!', CAST(N'2025-03-03T04:02:29.650' AS DateTime), NULL, N'/courses/toeic', 1)
    GO
    SET IDENTITY_INSERT [dbo].[Sliders] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Subjects] ON
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (1, 1, N'Vocabulary', N'Từ vựng cơ bản dành cho người mới bắt đầu.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (2, 1, N'Grammar Basics', N'Cấu trúc ngữ pháp cơ bản trong tiếng Anh.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (3, 1, N'Pronunciation Practice', N'Luyện phát âm chuẩn và tự nhiên cho người mới bắt đầu.', 3, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (4, 2, N'Basic Grammar', N'Kiến thức ngữ pháp cần thiết cho người học tiếng Anh cơ bản.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (5, 2, N'Daily Vocabulary', N'Từ vựng cơ bản dùng trong các tình huống hàng ngày.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (6, 2, N'Pronunciation', N'Phát âm đúng các từ cơ bản trong tiếng Anh.', 3, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (7, 3, N'Email Writing', N'Hướng dẫn viết email chuyên nghiệp trong công việc.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (8, 3, N'Meeting Vocabulary', N'Từ vựng cần thiết khi tham gia các cuộc họp.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (9, 3, N'Business Etiquette', N'Cách cư xử và giao tiếp trong môi trường kinh doanh.', 3, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (10, 4, N'Meeting English', N'Kỹ năng giao tiếp trong cuộc họp kinh doanh bằng tiếng Anh.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (11, 4, N'Negotiation English', N'Tiếng Anh cho các tình huống đàm phán kinh doanh.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (12, 4, N'Presentation Techniques', N'Cách chuẩn bị và trình bày bài thuyết trình trong môi trường kinh doanh.', 3, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (13, 5, N'Presentation Skills', N'Các kỹ thuật thuyết trình chuyên nghiệp cho môi trường công sở.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (14, 5, N'Advanced Email Writing', N'Viết email chuyên nghiệp cho các tình huống công việc phức tạp.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (15, 6, N'Daily Conversations', N'Thực hành các cuộc hội thoại hàng ngày trong tiếng Anh.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (16, 6, N'Situational Conversations', N'Giao tiếp tiếng Anh trong các tình huống thực tế.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (17, 7, N'Travel English', N'Tiếng Anh dành cho người đi du lịch: đặt phòng, hỏi đường, v.v.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (18, 7, N'Traveler Phrases', N'Các cụm từ cần thiết khi du lịch nước ngoài.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (19, 8, N'Listening Strategies', N'Chiến lược và mẹo làm bài nghe IELTS.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (20, 8, N'Writing Task 1', N'Hướng dẫn cách làm bài Writing Task 1 trong IELTS.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (21, 8, N'Speaking Practice', N'Luyện tập kỹ năng nói trong kỳ thi IELTS.', 3, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (22, 9, N'Writing Task 2', N'Cách viết bài luận Task 2 hiệu quả trong IELTS.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (23, 9, N'Speaking Confidence', N'Luyện phản xạ và tự tin khi nói trong IELTS.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (24, 10, N'Reading Comprehension', N'Chiến thuật làm bài đọc trong kỳ thi TOEFL.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (25, 10, N'TOEFL Writing', N'Kỹ thuật viết bài luận đạt điểm cao trong TOEFL.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (26, 11, N'TOEFL Listening', N'Chiến thuật và mẹo làm bài Listening trong TOEFL.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (27, 11, N'Writing for TOEFL', N'Cách viết bài luận trong TOEFL với tiêu chí đánh giá rõ ràng.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (28, 12, N'Interactive Vocabulary', N'Học từ vựng qua trò chơi cho trẻ em.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (29, 12, N'Phonics Sounds', N'Luyện phát âm các âm cơ bản trong tiếng Anh cho trẻ.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (30, 13, N'Phonics Practice', N'Luyện phát âm chuẩn cho trẻ em thông qua các bài tập.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (31, 13, N'Storytelling for Kids', N'Kể chuyện tiếng Anh cho trẻ em để cải thiện kỹ năng nghe và phát âm.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (32, 14, N'Basic Grammar Rules', N'Học các quy tắc ngữ pháp cơ bản trong tiếng Anh.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (33, 14, N'Advanced Grammar', N'Làm quen với các cấu trúc ngữ pháp phức tạp và nâng cao.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (34, 15, N'Tenses in English', N'Học các thì trong tiếng Anh và cách sử dụng chúng.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (35, 15, N'Grammar for Advanced Learners', N'Các cấu trúc ngữ pháp nâng cao dành cho người học tiếng Anh thành thạo.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (36, 16, N'Academic Writing', N'Kỹ năng viết bài luận học thuật chuyên sâu.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (37, 16, N'Research Writing', N'Cách viết báo cáo nghiên cứu và tài liệu học thuật.', 2, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (38, 17, N'Debate Techniques', N'Các kỹ thuật và chiến lược trong một cuộc tranh luận tiếng Anh.', 1, NULL)
    GO
    INSERT [dbo].[Subjects] ([SubjectID], [CourseID], [SubjectName], [Description], [OrderNo], [CreatedDate]) VALUES (39, 17, N'Public Speaking', N'Học cách thuyết trình tự tin và chuyên nghiệp trong tiếng Anh.', 2, NULL)
    GO
    SET IDENTITY_INSERT [dbo].[Subjects] OFF
    GO
    SET IDENTITY_INSERT [dbo].[Users] ON
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (1, N'admin01', N'Admin', N'User', N'Minh@12345678', N'admin01@example.com', N'0901234567', NULL, N'Male', N'avatar1.jpg', 30, 1, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (2, N'customer01', N'John', N'Doe', N'Minh@123456789', N'john.doe@example.com', N'0902345678', NULL, N'Male', N'avatar2.jpg', 25, 2, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (3, N'customer02', N'Jane', N'Smith', N'password123', N'jane.smith@example.com', N'0903456789', NULL, N'Female', N'avatar3.jpg', 28, 2, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (4, N'expert01', N'Alice', N'Johnson', N'password123', N'alice.johnson@example.com', N'0904567890', NULL, N'Female', N'avatar4.jpg', 35, 3, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (5, N'expert02', N'Bob', N'Williams', N'password123', N'bob.williams@example.com', N'0905678901', NULL, N'Male', N'avatar5.jpg', 40, 3, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (6, N'sale01', N'Charlie', N'Brown', N'password123', N'charlie.brown@example.com', N'0906789012', NULL, N'Male', N'avatar6.jpg', 32, 5, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (7, N'sale02', N'David', N'Martinez', N'password123', N'david.martinez@example.com', N'0907890123', NULL, N'Male', N'avatar7.jpg', 30, 5, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (8, N'marketing01', N'Eva', N'Davis', N'password123', N'eva.davis@example.com', N'0908901234', NULL, N'Female', N'avatar8.jpg', 27, 4, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (9, N'marketing02', N'Frank', N'Garcia', N'password123', N'frank.garcia@example.com', N'0909012345', NULL, N'Male', N'avatar9.jpg', 29, 4, 1)
    GO
    INSERT [dbo].[Users] ([UserID], [Username], [FirstName], [LastName], [Password], [Email], [PhoneNumber], [CreatedDate], [Gender], [Avatar], [Age], [RoleID], [Status]) VALUES (10, N'admin02', N'Sophia', N'Wilson', N'password123', N'sophia.wilson@example.com', N'0901230987', NULL, N'Female', N'avatar10.jpg', 33, 1, 1)
    GO
    SET IDENTITY_INSERT [dbo].[Users] OFF
    GO
/****** Object:  Index [UQ__Carts__A4AE64B93120BAE1]    Script Date: 3/20/2025 12:47:27 AM ******/
ALTER TABLE [dbo].[Carts] ADD  CONSTRAINT [UQ__Carts__A4AE64B93120BAE1] UNIQUE NONCLUSTERED
    (
    [CustomerID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
    GO
/****** Object:  Index [IX_Courses_CourseType_CreatedDate]    Script Date: 3/20/2025 12:47:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_CourseType_CreatedDate] ON [dbo].[Courses]
(
	[course_typeId] ASC,
	[CreatedDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Enrollments_CourseID]    Script Date: 3/20/2025 12:47:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_Enrollments_CourseID] ON [dbo].[Enrollments]
(
	[CourseID] ASC
)
INCLUDE([CustomerID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_PriceCourse_CourseID_SalePrice]    Script Date: 3/20/2025 12:47:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_PriceCourse_CourseID_SalePrice] ON [dbo].[PriceCourse]
(
	[CourseID] ASC,
	[SalePrice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReviewCourse_CourseID_Rating]    Script Date: 3/20/2025 12:47:27 AM ******/
CREATE NONCLUSTERED INDEX [IX_ReviewCourse_CourseID_Rating] ON [dbo].[ReviewCourse]
(
	[CourseID] ASC,
	[Rating] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Carts] ADD  DEFAULT (getdate()) FOR [CreatedDate]
    GO
ALTER TABLE [dbo].[CommentPost] ADD  DEFAULT (getdate()) FOR [CreateDate]
    GO
ALTER TABLE [dbo].[Courses] ADD  DEFAULT (getdate()) FOR [CreatedDate]
    GO
ALTER TABLE [dbo].[Enrollments] ADD  DEFAULT (getdate()) FOR [EnrollDate]
    GO
ALTER TABLE [dbo].[Experts] ADD  DEFAULT (getdate()) FOR [CreatedDate]
    GO
ALTER TABLE [dbo].[Lessons] ADD  DEFAULT (getdate()) FOR [CreatedDate]
    GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT (getdate()) FOR [CreateDate]
    GO
ALTER TABLE [dbo].[Posts] ADD  DEFAULT (getdate()) FOR [UpdateDate]
    GO
ALTER TABLE [dbo].[ReviewCourse] ADD  DEFAULT (getdate()) FOR [ReviewDate]
    GO
ALTER TABLE [dbo].[Subjects] ADD  DEFAULT (getdate()) FOR [CreatedDate]
    GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedDate]
    GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK__Carts__CustomerI__06CD04F7] FOREIGN KEY([CustomerID])
    REFERENCES [dbo].[Customers] ([CustomerID])
    GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK__Carts__CustomerI__06CD04F7]
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([ParentID])
    REFERENCES [dbo].[CommentPost] ([CommentPostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([ParentID])
    REFERENCES [dbo].[CommentPost] ([CommentPostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([ParentID])
    REFERENCES [dbo].[CommentPost] ([CommentPostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([ParentID])
    REFERENCES [dbo].[CommentPost] ([CommentPostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([PostID])
    REFERENCES [dbo].[Posts] ([PostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([PostID])
    REFERENCES [dbo].[Posts] ([PostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([PostID])
    REFERENCES [dbo].[Posts] ([PostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([PostID])
    REFERENCES [dbo].[Posts] ([PostID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[CommentPost]  WITH CHECK ADD FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([course_typeId])
    REFERENCES [dbo].[Course_Type] ([course_typeId])
    GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([course_typeId])
    REFERENCES [dbo].[Course_Type] ([course_typeId])
    GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([course_typeId])
    REFERENCES [dbo].[Course_Type] ([course_typeId])
    GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD FOREIGN KEY([course_typeId])
    REFERENCES [dbo].[Course_Type] ([course_typeId])
    GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK__Courses__ExpertI__08B54D69] FOREIGN KEY([ExpertID])
    REFERENCES [dbo].[Experts] ([ExpertID])
    GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK__Courses__ExpertI__08B54D69]
    GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Users]
    GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK__Enrollmen__Cours__0A9D95DB] FOREIGN KEY([CourseID])
    REFERENCES [dbo].[Courses] ([CourseID])
    GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK__Enrollmen__Cours__0A9D95DB]
    GO
ALTER TABLE [dbo].[Enrollments]  WITH CHECK ADD  CONSTRAINT [FK__Enrollmen__Custo__0B91BA14] FOREIGN KEY([CustomerID])
    REFERENCES [dbo].[Customers] ([CustomerID])
    GO
ALTER TABLE [dbo].[Enrollments] CHECK CONSTRAINT [FK__Enrollmen__Custo__0B91BA14]
    GO
ALTER TABLE [dbo].[Experts]  WITH CHECK ADD  CONSTRAINT [FK__Experts__UserID__0C85DE4D] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[Experts] CHECK CONSTRAINT [FK__Experts__UserID__0C85DE4D]
    GO
ALTER TABLE [dbo].[LessonFile]  WITH CHECK ADD  CONSTRAINT [FK_LessonFile_Lessons] FOREIGN KEY([LessonID])
    REFERENCES [dbo].[Lessons] ([LessonID])
    GO
ALTER TABLE [dbo].[LessonFile] CHECK CONSTRAINT [FK_LessonFile_Lessons]
    GO
ALTER TABLE [dbo].[LessonQuiz]  WITH CHECK ADD  CONSTRAINT [FK_LessonQuiz_Lessons] FOREIGN KEY([LessonID])
    REFERENCES [dbo].[Lessons] ([LessonID])
    GO
ALTER TABLE [dbo].[LessonQuiz] CHECK CONSTRAINT [FK_LessonQuiz_Lessons]
    GO
ALTER TABLE [dbo].[Lessons]  WITH CHECK ADD  CONSTRAINT [FK__Lessons__Subject__0D7A0286] FOREIGN KEY([SubjectID])
    REFERENCES [dbo].[Subjects] ([SubjectID])
    GO
ALTER TABLE [dbo].[Lessons] CHECK CONSTRAINT [FK__Lessons__Subject__0D7A0286]
    GO
ALTER TABLE [dbo].[LessonText]  WITH CHECK ADD  CONSTRAINT [FK_LessonText_Lessons] FOREIGN KEY([LessonID])
    REFERENCES [dbo].[Lessons] ([LessonID])
    GO
ALTER TABLE [dbo].[LessonText] CHECK CONSTRAINT [FK_LessonText_Lessons]
    GO
ALTER TABLE [dbo].[LessonVideo]  WITH CHECK ADD  CONSTRAINT [FK_LessonVideo_Lessons] FOREIGN KEY([LessonID])
    REFERENCES [dbo].[Lessons] ([LessonID])
    GO
ALTER TABLE [dbo].[LessonVideo] CHECK CONSTRAINT [FK_LessonVideo_Lessons]
    GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD  CONSTRAINT [FK__Marketing__UserI__0E6E26BF] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[Marketing] CHECK CONSTRAINT [FK__Marketing__UserI__0E6E26BF]
    GO
ALTER TABLE [dbo].[Notificaion]  WITH CHECK ADD  CONSTRAINT [FK__Notificai__UserI__0F624AF8] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[Notificaion] CHECK CONSTRAINT [FK__Notificai__UserI__0F624AF8]
    GO
ALTER TABLE [dbo].[PostReview]  WITH CHECK ADD  CONSTRAINT [FK_PostReview_Customers] FOREIGN KEY([CustomerID])
    REFERENCES [dbo].[Customers] ([CustomerID])
    GO
ALTER TABLE [dbo].[PostReview] CHECK CONSTRAINT [FK_PostReview_Customers]
    GO
ALTER TABLE [dbo].[PostReview]  WITH CHECK ADD  CONSTRAINT [FK_PostReview_Posts] FOREIGN KEY([PostID])
    REFERENCES [dbo].[Posts] ([PostID])
    GO
ALTER TABLE [dbo].[PostReview] CHECK CONSTRAINT [FK_PostReview_Posts]
    GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK__Posts__Marketing__10566F31] FOREIGN KEY([MarketingID])
    REFERENCES [dbo].[Marketing] ([MarketingID])
    GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK__Posts__Marketing__10566F31]
    GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_Posts_CategoryBlog] FOREIGN KEY([CategoryBlogID])
    REFERENCES [dbo].[CategoryBlog] ([CategoryBlogID])
    GO
ALTER TABLE [dbo].[Posts] CHECK CONSTRAINT [FK_Posts_CategoryBlog]
    GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_QuestionType] FOREIGN KEY([QuestionTypeID])
    REFERENCES [dbo].[QuestionType] ([QuestionTypeID])
    GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_QuestionType]
    GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Subjects] FOREIGN KEY([SubjectId])
    REFERENCES [dbo].[Subjects] ([SubjectID])
    GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Subjects]
    GO
ALTER TABLE [dbo].[QuestionAnswer]  WITH CHECK ADD  CONSTRAINT [FK_QuestionAnswer_Question] FOREIGN KEY([QuestionID])
    REFERENCES [dbo].[Question] ([QuestionID])
    GO
ALTER TABLE [dbo].[QuestionAnswer] CHECK CONSTRAINT [FK_QuestionAnswer_Question]
    GO
ALTER TABLE [dbo].[QuestionImages]  WITH CHECK ADD  CONSTRAINT [FK_QuestionImages_Question] FOREIGN KEY([QuestionImageID])
    REFERENCES [dbo].[Question] ([QuestionID])
    GO
ALTER TABLE [dbo].[QuestionImages] CHECK CONSTRAINT [FK_QuestionImages_Question]
    GO
ALTER TABLE [dbo].[QuizAttend]  WITH CHECK ADD  CONSTRAINT [FK_QuizAttend_LessonQuiz] FOREIGN KEY([LessonQuizID])
    REFERENCES [dbo].[LessonQuiz] ([LessonQuizID])
    GO
ALTER TABLE [dbo].[QuizAttend] CHECK CONSTRAINT [FK_QuizAttend_LessonQuiz]
    GO
ALTER TABLE [dbo].[QuizAttend]  WITH CHECK ADD  CONSTRAINT [FK_QuizAttend_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([UserID])
    GO
ALTER TABLE [dbo].[QuizAttend] CHECK CONSTRAINT [FK_QuizAttend_Users]
    GO
ALTER TABLE [dbo].[QuizQuestions]  WITH CHECK ADD  CONSTRAINT [FK_QuizQuestions_LessonQuiz] FOREIGN KEY([LessonQuizID])
    REFERENCES [dbo].[LessonQuiz] ([LessonQuizID])
    GO
ALTER TABLE [dbo].[QuizQuestions] CHECK CONSTRAINT [FK_QuizQuestions_LessonQuiz]
    GO
ALTER TABLE [dbo].[QuizQuestions]  WITH CHECK ADD  CONSTRAINT [FK_QuizQuestions_Question] FOREIGN KEY([QuestionID])
    REFERENCES [dbo].[Question] ([QuestionID])
    GO
ALTER TABLE [dbo].[QuizQuestions] CHECK CONSTRAINT [FK_QuizQuestions_Question]
    GO
ALTER TABLE [dbo].[QuizResultDetail]  WITH CHECK ADD  CONSTRAINT [FK_QuizResultDetail_Question] FOREIGN KEY([QuestionID])
    REFERENCES [dbo].[Question] ([QuestionID])
    GO
ALTER TABLE [dbo].[QuizResultDetail] CHECK CONSTRAINT [FK_QuizResultDetail_Question]
    GO
ALTER TABLE [dbo].[QuizResultDetail]  WITH CHECK ADD  CONSTRAINT [FK_QuizResultDetail_QuizAttend] FOREIGN KEY([QuizAttendID])
    REFERENCES [dbo].[QuizAttend] ([QuizAttendID])
    GO
ALTER TABLE [dbo].[QuizResultDetail] CHECK CONSTRAINT [FK_QuizResultDetail_QuizAttend]
    GO
ALTER TABLE [dbo].[QuizResultDetailImage]  WITH CHECK ADD  CONSTRAINT [FK_QuizResultDetailImage_QuizResultDetail] FOREIGN KEY([ImageQuizID])
    REFERENCES [dbo].[QuizResultDetail] ([QuizResultDetailID])
    GO
ALTER TABLE [dbo].[QuizResultDetailImage] CHECK CONSTRAINT [FK_QuizResultDetailImage_QuizResultDetail]
    GO
ALTER TABLE [dbo].[ReviewCourse]  WITH CHECK ADD  CONSTRAINT [FK__ReviewCourse__CourseI__1332DBDC] FOREIGN KEY([CourseID])
    REFERENCES [dbo].[Courses] ([CourseID])
    GO
ALTER TABLE [dbo].[ReviewCourse] CHECK CONSTRAINT [FK__ReviewCourse__CourseI__1332DBDC]
    GO
ALTER TABLE [dbo].[ReviewCourse]  WITH CHECK ADD  CONSTRAINT [FK__ReviewCourse__Custome__14270015] FOREIGN KEY([CustomerID])
    REFERENCES [dbo].[Customers] ([CustomerID])
    GO
ALTER TABLE [dbo].[ReviewCourse] CHECK CONSTRAINT [FK__ReviewCourse__Custome__14270015]
    GO
ALTER TABLE [dbo].[Sliders]  WITH CHECK ADD  CONSTRAINT [FK_Sliders_Marketing] FOREIGN KEY([MarketingID])
    REFERENCES [dbo].[Marketing] ([MarketingID])
    GO
ALTER TABLE [dbo].[Sliders] CHECK CONSTRAINT [FK_Sliders_Marketing]
    GO
ALTER TABLE [dbo].[Subjects]  WITH CHECK ADD  CONSTRAINT [FK__Subjects__Course__160F4887] FOREIGN KEY([CourseID])
    REFERENCES [dbo].[Courses] ([CourseID])
    GO
ALTER TABLE [dbo].[Subjects] CHECK CONSTRAINT [FK__Subjects__Course__160F4887]
    GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
    REFERENCES [dbo].[Roles] ([RoleID])
    GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
    REFERENCES [dbo].[Roles] ([RoleID])
    GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
    REFERENCES [dbo].[Roles] ([RoleID])
    GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
    REFERENCES [dbo].[Roles] ([RoleID])
    GO
ALTER TABLE [dbo].[Experts]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
ALTER TABLE [dbo].[Experts]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
ALTER TABLE [dbo].[Experts]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
ALTER TABLE [dbo].[Experts]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
ALTER TABLE [dbo].[Marketing]  WITH CHECK ADD CHECK  (([ExperienceYears]>=(0)))
    GO
    USE [master]
    GO
ALTER DATABASE [SWP52] SET  READ_WRITE

-- Thêm dữ liệu cho bảng Lessons
SET IDENTITY_INSERT [dbo].[Lessons] ON
GO
INSERT [dbo].[Lessons] ([LessonID], [SubjectID], [LessonName], [Content], [Duration], [OrderNo], [status_lesson], [CreatedDate], [Type], [UpdateDate]) 
VALUES
    (1, 1, N'Basic Vocabulary - Nouns', N'Học các danh từ cơ bản dùng hàng ngày', 60, 1, 1, CAST(N'2025-03-03T00:00:00.000' AS DateTime), N'Video', NULL),
    (2, 1, N'Basic Vocabulary - Verbs', N'Các động từ thường gặp trong giao tiếp', 50, 2, 1, CAST(N'2025-03-03T00:00:00.000' AS DateTime), N'Text', NULL),
    (3, 2, N'Present Simple Tense', N'Cấu trúc và cách sử dụng thì hiện tại đơn', 45, 1, 1, CAST(N'2025-03-03T00:00:00.000' AS DateTime), N'Video', NULL),
    (4, 2, N'Past Simple Tense', N'Cách sử dụng thì quá khứ đơn', 45, 2, 1, CAST(N'2025-03-03T00:00:00.000' AS DateTime), N'Text', NULL),
    (5, 3, N'English Vowel Sounds', N'Luyện phát âm nguyên âm tiếng Anh', 30, 1, 1, CAST(N'2025-03-03T00:00:00.000' AS DateTime), N'Audio', NULL),
    (6, 4, N'Basic Grammar Rules', N'Học các quy tắc ngữ pháp cơ bản', 55, 1, 1, CAST(N'2025-03-03T00:00:00.000' AS DateTime), N'Video', NULL)
GO
SET IDENTITY_INSERT [dbo].[Lessons] OFF
GO

-- Thêm dữ liệu cho bảng LessonQuiz
SET IDENTITY_INSERT [dbo].[LessonQuiz] ON
GO
INSERT [dbo].[LessonQuiz] ([LessonQuizID], [LessonID], [PassPercentage], [TimeLimit], [AttemptAllowed], [Status]) VALUES 
    (1, 1, 70, 30, 3, 1),
    (2, 3, 75, 25, 2, 1),
    (3, 5, 80, 20, 2, 1),
    (4, 6, 65, 40, 3, 1)
GO
SET IDENTITY_INSERT [dbo].[LessonQuiz] OFF
GO

-- Dữ liệu cho bảng QuizQuestions (sử dụng QuestionID từ 3 đến 12 đã có sẵn trong DB)
INSERT [dbo].[QuizQuestions] ([LessonQuizID], [QuestionID], [SortOrder]) VALUES
    (1, 3, 1),
    (1, 4, 2),
    (1, 5, 3),
    (2, 6, 1),
    (2, 7, 2),
    (2, 8, 3),
    (3, 9, 1),
    (3, 10, 2),
    (4, 11, 1),
    (4, 12, 2)
GO

-- Dữ liệu cho bảng QuizAttend
SET IDENTITY_INSERT [dbo].[QuizAttend] ON
GO
INSERT [dbo].[QuizAttend] ([QuizAttendID], [UserID], [LessonQuizID], [Score], [Passed], [StartTime], [EndTime]) VALUES
    (1, 2, 1, 85.5, 1, CAST(N'2025-03-05T09:00:00.000' AS DateTime), CAST(N'2025-03-05T09:25:00.000' AS DateTime)),
    (2, 3, 1, 72.0, 1, CAST(N'2025-03-05T10:00:00.000' AS DateTime), CAST(N'2025-03-05T10:28:00.000' AS DateTime)),
    (3, 2, 2, 68.0, 0, CAST(N'2025-03-05T11:00:00.000' AS DateTime), CAST(N'2025-03-05T11:18:00.000' AS DateTime)),
    (4, 3, 3, 90.0, 1, CAST(N'2025-03-06T14:00:00.000' AS DateTime), CAST(N'2025-03-06T14:15:00.000' AS DateTime)),
    (5, 2, 4, 75.0, 1, CAST(N'2025-03-07T16:30:00.000' AS DateTime), CAST(N'2025-03-07T17:05:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[QuizAttend] OFF
GO
