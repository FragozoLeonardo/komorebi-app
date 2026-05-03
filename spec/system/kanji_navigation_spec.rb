# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Kanji navigation", type: :system do
  let!(:n5_level) { create(:jlpt_level, :n5) }

  let!(:person_kanji) do
    create(
      :kanji,
      jlpt_level: n5_level,
      kanji: "人",
      meaning: "Pessoa",
      on_reading: "ジン, ニン",
      kun_reading: "ひと",
      mnemonic: "Representação de uma pessoa de pé, vista de perfil."
    )
  end

  let!(:one_kanji) do
    create(
      :kanji,
      jlpt_level: n5_level,
      kanji: "一",
      meaning: "Um",
      on_reading: "イチ, イツ",
      kun_reading: "ひと, ひと-つ",
      mnemonic: "Um único traço horizontal representando a unidade um."
    )
  end

  let!(:sun_kanji) do
    create(
      :kanji,
      jlpt_level: n5_level,
      kanji: "日",
      meaning: "Dia, sol",
      on_reading: "ニチ, ジツ",
      kun_reading: "ひ, か",
      mnemonic: "Desenho do sol, cuja passagem marca a duração de um dia."
    )
  end

  context "when visiting the N5 list page" do
    it "shows the page title and the kanji cards" do
      visit study_n5_path

      expect(page).to have_content("Kanji N5")

      expect(page).to have_content("人")
      expect(page).to have_content("Pessoa")

      expect(page).to have_content("一")
      expect(page).to have_content("Um")

      expect(page).to have_content("日")
      expect(page).to have_content("Dia, sol")
    end

    it "shows only kanji from the N5 level" do
      create(
        :kanji,
        jlpt_level: create(:jlpt_level, :n4),
        kanji: "猫",
        meaning: "Gato"
      )

      visit study_n5_path

      expect(page).to have_content("人")
      expect(page).to have_content("一")
      expect(page).to have_content("日")

      expect(page).not_to have_content("猫")
      expect(page).not_to have_content("Gato")
    end
  end

  context "when navigating to a kanji detail page" do
    it "opens the detail page when the user clicks a kanji from the N5 list" do
      visit study_n5_path

      click_link "日"

      expect(page).to have_current_path(kanji_path(sun_kanji))
      expect(page).to have_content("日")
      expect(page).to have_content("Dia, sol")
      expect(page).to have_content("ニチ, ジツ")
      expect(page).to have_content("ひ, か")
      expect(page).to have_content("Desenho do sol, cuja passagem marca a duração de um dia.")
    end

    it "allows the user to return to the N5 page from the detail page" do
      visit kanji_path(sun_kanji)

      click_link "← Voltar para N5"

      expect(page).to have_current_path(study_n5_path)
      expect(page).to have_content("Kanji N5")
      expect(page).to have_content("人")
      expect(page).to have_content("一")
      expect(page).to have_content("日")
    end
  end

  context "when optional fields are missing" do
    let!(:mountain_kanji) do
      create(
        :kanji,
        jlpt_level: n5_level,
        kanji: "山",
        meaning: "Montanha",
        on_reading: nil,
        kun_reading: nil,
        mnemonic: nil
      )
    end

    it "shows fallback content on the detail page" do
      visit kanji_path(mountain_kanji)

      expect(page).to have_content("山")
      expect(page).to have_content("Montanha")
      expect(page).to have_content("—")
      expect(page).to have_content("Nenhum mnemônico cadastrado ainda.")
    end
  end
end
