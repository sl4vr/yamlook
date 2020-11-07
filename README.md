# Yamlook

Yamlook searches for dot-notated yaml keys occurrences in yaml files. It might be handy if you have localization
or deep configs and you don't know where one or another value comes from.

For instance you have such code:
```
<%= link_to t("admin.marketing.reports.some_report.title"), some_report_path(format: "csv") %>
```
Run `yamlook admin.marketing.reports.some_report.title` in terminal and it will show up all occurrences of that value
in your internationalization yaml files. If you have all the internationalization in one yaml file, you will likely
have to specify some root key as well, e.g. `yamlook en.admin.marketing.reports.some_report.title`.

## Installation

```
$ gem install yamlook
```

## Usage

Run yamlook in terminal with dot-notated yaml keys as argument:
```
$ yamlook some.deep.key.in.you.yaml.file
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[sl4vr]/yamlook.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
