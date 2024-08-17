package routes

import (
	"crowdstriker/public"

	"github.com/gin-gonic/gin"
)

func Setup(app *gin.Engine) {
	//app.GET("/404-page", handlers.ErrorPage)
	app.GET("/", func(c *gin.Context) {

	})
	app.StaticFS("/public", public.GetPublicAssetsFileSystem())
}
