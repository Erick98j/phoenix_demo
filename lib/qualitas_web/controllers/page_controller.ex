defmodule QualitasWeb.PageController do
  use QualitasWeb, :controller

  def policies(conn, _params) do
    policies = Qualitas.Poliza.get_policies()

    conn |>
    assign(:polizas, policies) |>
    render("policies.html",
      layout: {QualitasWeb.LayoutView, "admin.html"})
  end

  def finished(conn, _params) do
    policies = Qualitas.Poliza.get_policies_finished()

    conn |>
    assign(:polizas, policies) |>
    render("policies_finished.html",
      layout: {QualitasWeb.LayoutView, "admin.html"})
  end

  def to_due(conn, _params) do
    policies = Qualitas.Poliza.get_policies_to_due()

    conn |>
    assign(:polizas, policies) |>
    render("policies_to_due.html",
      layout: {QualitasWeb.LayoutView, "admin.html"})
  end

  def cancelled(conn, _params) do
    policies = Qualitas.Poliza.get_policies_cancelled()

    conn |>
    assign(:polizas, policies) |>
    render("policies_cancelled.html",
      layout: {QualitasWeb.LayoutView, "admin.html"})
  end

  def policy(conn, _params) do
      render(conn, "policy.html",
      layout: {QualitasWeb.LayoutView, "admin.html"})
  end

end
