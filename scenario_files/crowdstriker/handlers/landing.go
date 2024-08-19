package handlers

import (
	"crowdstriker/utils"
	"crowdstriker/views/landing"
	"net/http"

	"github.com/gin-gonic/gin"
)

func LandingHandler(context *gin.Context) {
	render := utils.NewTempl(context, http.StatusOK, landing.IndexPage())
	context.Render(http.StatusOK, render)
}
