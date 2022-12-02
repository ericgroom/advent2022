defmodule Advent2022.Inputs do
  @inputs_dir __DIR__ |> Path.join("inputs")

  def input(day_no) do
    path = input_path(day_no)

    if File.exists?(path) do
      File.read!(path)
    else
      nil
    end
  end

  def input_path(day_no) when is_integer(day_no) do
    @inputs_dir |> Path.join("day_" <> Integer.to_string(day_no) <> ".txt")
  end

  def download_input(day_no) when is_integer(day_no) do
    :inets.start()
    :ssl.start()
    path_to_file = input_path(day_no)

    headers = [
      {'cookie', session_token()},
      {'user-agent', "github.com/ericgroom/advent2022 by bcgroom@gmail.com"}
    ]

    if File.exists?(path_to_file) do
      raise "input file already exists!"
    end

    File.touch!(path_to_file)

    url = "https://adventofcode.com/2022/day/#{day_no}/input"

    http_request_opts = [
      ssl: [
        verify: :verify_peer,
        cacerts: :public_key.cacerts_get(),
        customize_hostname_check: [
          match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
        ]
      ]
    ]

    {:ok, :saved_to_file} =
      :httpc.request(:get, {url, headers}, http_request_opts,
        stream: String.to_charlist(path_to_file)
      )
  end

  defp session_token() do
    Application.fetch_env!(:advent2022, :session)
  end
end
