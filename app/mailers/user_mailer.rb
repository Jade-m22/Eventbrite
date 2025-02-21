class UserMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Bienvenue sur notre plateforme !")
  end

  def participant_email(attendance)
    @attendance = attendance
    @event = @attendance.event
    @organizer = @event.user
    @participant = @attendance.user
    mail(to: @organizer.email, subject: "Un participant s'est inscrit à votre événement !")
  end
end
