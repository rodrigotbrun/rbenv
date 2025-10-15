use color_eyre::Result;
use crossterm::event::{self, Event};
use ratatui::{DefaultTerminal, Frame, layout::Rect, style::Stylize, widgets::Paragraph};

fn main() -> Result<()> {
    color_eyre::install()?;
    let terminal = ratatui::init();
    let result = run(terminal);
    ratatui::restore();
    result
}

fn run(mut terminal: DefaultTerminal) -> Result<()> {
    loop {
        terminal.draw(render)?;
        if matches!(event::read()?, Event::Key(_)) {
            break Ok(());
        }
    }
}

fn render(frame: &mut Frame) {
    frame.render_widget("hello world", frame.area());

    for i in 0..10 {
        let area = Rect::new(0, i, frame.area().width, 1);
        frame.render_widget(
            Paragraph::new("Hello world!").centered().bold().cyan(),
            area,
        );
    }
}
