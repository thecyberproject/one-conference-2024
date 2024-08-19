package routes

import (
	"crowdstriker/handlers"
	"crowdstriker/public"

	"github.com/gin-gonic/gin"
)

func Setup(app *gin.Engine) {
	//app.GET("/404-page", handlers.ErrorPage)
	app.GET("/", handlers.LandingHandler)
	app.StaticFS("/public", public.GetPublicAssetsFileSystem())
}
