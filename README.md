# OuiQuery

**OuiQuery can download, parse, and query the Wireshark OUI database.**

## Installation

This package can be installed by adding `oui_query` to your list of dependencies
in `mix.exs`:

```elixir
def deps do
  [
    {:oui_query, "~> 0.1.0"}
  ]
end
```

## Example

```elixir
OuiQuery.get_db |> OuiQuery.get_vendor("MA:CA:DD:RR:ES:S!")
```

## Documentation

Docs can be found at
[https://hexdocs.pm/oui_query](https://hexdocs.pm/oui_query).
